//
//  InputField.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 22.11.2025.
//

import SwiftUI

/// UI component representing an input field with various states and configurations.
public struct InputField: View {
  // MARK: - Nested Types

  private enum Constants {
    static let loadingString = "Long loading string"
    static let textFieldHeight: CGFloat = 56
    static let clearIconName = "xmark.circle.fill"
  }
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme
  @Environment(\.isLoading)
  private var isLoading
  @Environment(\.isEnabled)
  private var isEnabled

  // MARK: - State Properties

  @Binding private var text: String
  @State private var formattedText = String()
  @State private var formattedTextBuffer: (oldValue: String, currentValue: String) = (String(), String())
  @FocusState private var isFocused: Bool

  // MARK: - Private Properties

  private let label: String
  private let inputFieldState: InputFieldState
  private let hasClearIcon: Bool
  private let leadingIconConfig: IconConfig?
  private let trailingIconConfig: IconConfig?
  private let visualTransformation: VisualTransformation?

  // MARK: - Initializer

  /// Creates a new Input Field component.
  /// - Parameters:
  ///   - text: Binding to the text value of the input field.
  ///   - label: The label displayed above the input field.
  ///   - inputFieldState: The state of the input field (normal, disabled, error).
  ///   - hasClearIcon: A boolean indicating whether the clear icon should be shown.
  ///   - leadingIconConfig: An optional leading icon configuration.
  ///   - trailingIconConfig: An optional trailing icon configuration.
  ///   - visualTransformation: An optional visual transformation for the text input.
  public init(
    text: Binding<String>,
    label: String,
    inputFieldState: InputFieldState = .normal,
    hasClearIcon: Bool = false,
    leadingIconConfig: IconConfig? = nil,
    trailingIconConfig: IconConfig? = nil,
    visualTransformation: VisualTransformation? = nil
  ) {
    self._text = text
    self.label = label
    self.inputFieldState = inputFieldState
    self.hasClearIcon = hasClearIcon
    self.leadingIconConfig = leadingIconConfig
    self.trailingIconConfig = trailingIconConfig
    self.visualTransformation = visualTransformation
  }

  // MARK: - Body

  public var body: some View {
    contentView
      .frame(maxWidth: .infinity)
      .isEnabled(inputFieldState != .disabled)
  }

  // MARK: - Subviews

  @ViewBuilder private var contentView: some View {
    if isLoading {
      loadingContentView
    } else {
      loadedContentView
    }
  }

  // MARK: - Loading State

  private var loadingContentView: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerL) {
      VStack(alignment: .leading, spacing: .zero) {
        Text(Constants.loadingString)
          .font(theme.typography.body.body)
        RegularDivider()
      }
      Text(Constants.loadingString)
        .font(theme.typography.title.title2)
    }
    .redacted(reason: .placeholder)
    .shimmer(style: ShimmerStyle(theme: theme))
  }

  // MARK: - Subviews

  private var loadedContentView: some View {
    VStack(spacing: theme.spacing.spacerL) {
      labelView
      textField
    }
    .padding(theme.spacing.spacerL)
    .onChange(of: text) { oldValue, newValue in
      if oldValue != newValue {
        formatText(newValue)
      }
    }
  }

  private var labelView: some View {
    VStack(spacing: .zero) {
      Text(label)
        .font(theme.typography.body.subheadline)
        .foregroundColor(labelColor)
        .frame(maxWidth: .infinity, alignment: .leading)
      RegularDivider()
    }
  }

  private var textField: some View {
    HStack(spacing: theme.spacing.spacerS) {
      makeIconView(iconConfig: leadingIconConfig)
      textFieldView
        .frame(maxWidth: .infinity, minHeight: Constants.textFieldHeight)
        .font(theme.typography.body.body)
        .focused($isFocused)
        .disabled(inputFieldState == .disabled)
        .tint(theme.colorPalette.border.primary)
        .foregroundStyle(contentColor)
        .onChange(of: formattedText) { _, newValue in
          if newValue != formattedTextBuffer.currentValue {
            formattedTextBuffer = (formattedTextBuffer.currentValue, newValue)
          }
          formatText(newValue)
        }
      HStack(spacing: theme.spacing.spacerXS) {
        clearIconView
        makeIconView(iconConfig: trailingIconConfig)
      }
    }
    .padding(.horizontal, theme.spacing.spacerS)
    .overlay {
      borderView
    }
  }

  private var textFieldView: some View {
    TextField(
      String(),
      text: visualTransformation != nil ? $formattedText : $text
    )
  }

  @ViewBuilder private var borderView: some View {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusS)
      .stroke(borderColor, lineWidth: theme.spacing.lineWidth)
  }

  @ViewBuilder private var clearIconView: some View {
    if hasClearIcon && !text.isEmpty && inputFieldState != .disabled && isFocused {
      Button {
        text = String()
      } label: {
        Image(systemName: Constants.clearIconName)
          .resizable()
          .renderingMode(.template)
          .frame(width: theme.iconSize.iconL, height: theme.iconSize.iconL)
      }
      .buttonStyle(.plain)
      .foregroundStyle(theme.colorPalette.icon.secondary)
    }
  }

  // MARK: - View Builders

  @ViewBuilder
  private func makeIconView(iconConfig: IconConfig?) -> some View {
    if let iconConfig {
      if iconConfig.action == nil {
        makeIcon(iconConfig: iconConfig)
      } else {
        makeActionIconView(iconConfig: iconConfig)
      }
    }
  }

  private func makeActionIconView(iconConfig: IconConfig) -> some View {
    Button {
      iconConfig.action?()
    } label: {
      makeIcon(iconConfig: iconConfig)
    }
  }

  @ViewBuilder
  private func makeIcon(iconConfig: IconConfig) -> some View {
    Image(systemName: iconConfig.name)
      .resizable()
      .renderingMode(.template)
      .frame(width: theme.iconSize.iconXXL, height: theme.iconSize.iconXXL)
      .foregroundStyle(makeIconColor(iconConfig: iconConfig))
  }
}

// MARK: - Color Helpers

extension InputField {
  // MARK: - Helper Properties

  private var labelColor: Color {
    switch inputFieldState {
    case .normal:
      theme.colorPalette.text.secondary
    case .disabled:
      theme.colorPalette.text.disabled
    case .error:
      theme.colorPalette.text.negative
    }
  }

  private var borderColor: Color {
    switch inputFieldState {
    case .normal:
      theme.colorPalette.border.primary
    case .disabled:
      theme.colorPalette.text.disabled
    case .error:
      theme.colorPalette.border.negative
    }
  }

  private var contentColor: Color {
    switch inputFieldState {
    case .normal:
      theme.colorPalette.text.primary
    case .disabled:
      theme.colorPalette.text.disabled
    case .error:
      theme.colorPalette.text.negative
    }
  }

  // MARK: - Helper Methods

  private func makeIconColor(iconConfig: IconConfig) -> Color {
    switch inputFieldState {
    case .normal:
      return theme.colorPalette.icon.primary
    case .disabled:
      if let isEnabled = iconConfig.isEnabled, isEnabled {
        return theme.colorPalette.icon.primary
      }
      return theme.colorPalette.icon.disabled
    case .error:
      return theme.colorPalette.icon.primary
    }
  }
}

// MARK: - Text Helpers

extension InputField {
  // MARK: - Private Methods

  private func formatText(_ value: String) {
    guard let visualTransformation else {
      self.formattedText = value
      return
    }
    if visualTransformation.isValidForTransformation(value) {
      let transformation = visualTransformation.transform(value)
      self.text = transformation.0
      self.formattedText = transformation.1
    } else {
      self.formattedText = formattedTextBuffer.oldValue
    }
  }
}
