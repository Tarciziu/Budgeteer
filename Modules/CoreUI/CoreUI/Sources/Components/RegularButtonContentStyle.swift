//
//  RegularButtonContentStyle.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 29.10.2025.
//

import SwiftUI

/// Creates the style for the regular button.
public struct RegularButtonContentStyle: ButtonStyle {
  // MARK: - Nested Types

  private enum Constants {
    static let border: CGFloat = 1
    static let borderPressed: CGFloat = 2
  }

  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme
  @Environment(\.isLoading)
  private var isLoading

  @Environment(\.isEnabled)
  private var isEnabled

  // MARK: - Private Properties

  private let type: RegularButton.ButtonType
  private let text: any StringProtocol
  private let imageName: String?
  private let progressView: ButtonProgressViewBuilder?

  private var defaultTextColor: Color {
    switch type {
    case .primary:
      return theme.colorPalette.text.inverted
    case .secondary:
      return theme.colorPalette.text.primary
    }
  }

  private var pressedTextColor: Color {
    switch type {
    case .primary:
      return theme.colorPalette.text.inverted
    case .secondary:
      return theme.colorPalette.text.primary
    }
  }

  private var disabledTextColor: Color {
    theme.colorPalette.text.disabled
  }

  private var defaultSurfaceColor: Color {
    switch type {
    case .primary:
      return theme.colorPalette.surface.inverted
    case .secondary:
      return theme.colorPalette.surface.secondary
    }
  }

  private var pressedSurfaceColor: Color {
    switch type {
    case .primary:
      return theme.colorPalette.surface.dark
    case .secondary:
      return theme.colorPalette.surface.secondaryPressed
    }
  }

  private var disabledSurfaceColor: Color {
    theme.colorPalette.surface.disabled
  }

  private var defaultIconColor: Color {
    switch type {
    case .primary:
      return theme.colorPalette.text.inverted
    case .secondary:
      return theme.colorPalette.text.primary
    }
  }

  private var pressedIconColor: Color {
    switch type {
    case .primary:
      return theme.colorPalette.text.inverted
    case .secondary:
      return theme.colorPalette.text.primary
    }
  }

  private var disabledIconColor: Color {
    switch type {
    case .primary:
      return theme.colorPalette.icon.disabled
    case .secondary:
      return theme.colorPalette.icon.disabled
    }
  }

  // MARK: - Initializer

  /// Initializes a new instance of `RegularButtonContentStyle`.
  /// - Parameters:
  ///   - type: Type of the RegularButton.
  ///   - text: String representing the text to be displayed.
  ///   - imageName: Optional string representing the system image name to be displayed.
  ///   - progressView: Optional custom progress view builder.
  public init(
    type: RegularButton.ButtonType,
    text: any StringProtocol,
    imageName: String?,
    progressView: ButtonProgressViewBuilder?
  ) {
    self.type = type
    self.text = text
    self.imageName = imageName
    self.progressView = progressView
  }

  // MARK: - ButtonStyle Conformance

  public func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .center, spacing: theme.spacing.spacerS) {
      makeButtonContent(for: configuration)
    }
    .padding(.horizontal, theme.spacing.spacerXL)
    .padding(.vertical, theme.spacing.spacerM)
    .foregroundStyle(getTextColor(for: configuration))
    .background(getSurfaceColor(for: configuration))
    .clipShape(roundingShape)
    .glassEffect(.regular, in: roundingShape)
    .if(type == .secondary) { view in
      view
        .overlay(makeRoundedRectangle(configuration: configuration))
    }
  }

  // MARK: - Shape

  private var roundingShape: some Shape {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusXL)
  }

  // MARK: - Private View Builders

  private func makeRoundedRectangle(configuration: Configuration) -> some View {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusXL)
      .inset(by: theme.spacing.lineWidth)
      .strokeBorder(
        theme.colorPalette.border.primary,
        lineWidth: configuration.isPressed ? Constants.borderPressed : Constants.border,
        antialiased: true
      )
  }

  @ViewBuilder
  private func makeButtonContent(for configuration: Configuration) -> some View {
    if isLoading && isEnabled {
      makeProgressView()
    } else {
      makeDefaultView(for: configuration)
    }
  }

  private func makeDefaultView(for configuration: Configuration) -> some View {
    Group {
      if let imageName {
        makeSystemImage(for: imageName, with: configuration)
      }
      if !text.isEmpty {
        Text(text)
          .font(theme.typography.title.headline)
      }
    }
  }

  private func makeSystemImage(for imageName: String, with configuration: Configuration) -> some View {
    Image(systemName: imageName)
      .renderingMode(.template)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .foregroundStyle(getIconColor(for: configuration))
      .frame(width: theme.iconSize.iconXL, height: theme.iconSize.iconXL)
  }

  // MARK: - Progress View

  private func makeProgressView() -> some View {
    if let progressView {
      return AnyView(progressView())
    }
    return AnyView(defaultProgressView)
  }

  private var defaultProgressView: some View {
    ProgressView()
      .frame(width: theme.iconSize.iconXL, height: theme.iconSize.iconXL)
  }

  // MARK: - Private Methods

  private func getTextColor(for configuration: Configuration) -> Color {
    guard isEnabled else {
      return disabledTextColor
    }
    guard configuration.isPressed && !isLoading else { return defaultTextColor }
    return pressedTextColor
  }

  private func getIconColor(for configuration: Configuration) -> Color {
    guard isEnabled else {
      return disabledIconColor
    }
    guard configuration.isPressed && !isLoading else { return defaultIconColor }
    return pressedIconColor
  }

  private func getSurfaceColor(for configuration: Configuration) -> Color {
    guard isEnabled else { return disabledSurfaceColor }
    if type == .secondary {
      return .clear
    }

    guard configuration.isPressed && !isLoading else { return defaultSurfaceColor }
    return pressedSurfaceColor
  }
}
