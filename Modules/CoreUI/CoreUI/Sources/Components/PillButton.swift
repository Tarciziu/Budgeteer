//
//  PillButton.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 02.11.2025.
//

import SwiftUI

/// Reusable component dedicated for representing a pill buttons.
public struct PillButton: View {
  // MARK: - Observed Properties

  @Environment(BTTheme.self)
  private var theme: BTTheme

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let content: Content

  // MARK: - Init

  /// Creates a new pill button.
  /// - Parameter content: The content model used by the component.
  public init(content: Content) {
    self.content = content
  }

  // MARK: - Boady

  public var body: some View {
    Button {
      content.action?()
    } label: {
      buttonView
    }
  }

  private var buttonView: some View {
    HStack(spacing: theme.spacing.spacerS) {
      leadingIcon
      label
      trailingIcon
    }
    .padding(theme.spacing.spacerM)
    .background(backgroundColor)
    .clipShape(roundingShape)
    .overlay {
      borderView
    }
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
  }

  // MARK: - Subviews

  @ViewBuilder private var leadingIcon: some View {
    if let leadingIcon = content.leadingIcon {
      Image(systemName: leadingIcon)
        .resizable()
        .foregroundStyle(theme.colorPalette.icon.primary)
        .frame(width: theme.iconSize.iconXXS, height: theme.iconSize.iconXXS)
    }
  }

  @ViewBuilder private var trailingIcon: some View {
    if let trailingIcon = content.trailingIcon {
      Image(systemName: trailingIcon)
        .resizable()
        .foregroundStyle(theme.colorPalette.icon.primary)
        .frame(width: theme.iconSize.iconXXS, height: theme.iconSize.iconXXS)
    }
  }

  private var label: some View {
    Text(content.label)
      .foregroundStyle(textColor)
      .font(theme.typography.body.subheadline)
  }

  private var textColor: Color {
    switch content.type {
    case .idle:
      return theme.colorPalette.text.primary
    default:
      return theme.colorPalette.surface.light
    }
  }

  private var backgroundColor: Color {
    switch content.type {
    case .error:
      theme.colorPalette.text.negative
    case .idle:
      theme.colorPalette.surface.light
    case .highlight:
      theme.colorPalette.bottomSheet.button
    }
  }

  private var roundingShape: some Shape {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusXL)
  }

  @ViewBuilder private var borderView: some View {
    roundingShape
      .stroke(theme.colorPalette.icon.disabled, lineWidth: theme.spacing.lineWidth)
  }
}

// MARK: Content Model

public extension PillButton {
  /// Indicates the type of the button.
  enum ButtonType {
    /// By default signaled by the red background
    case error
    /// By default signaled by the invisible background
    case idle
    /// By default signaled by the blue background
    case highlight
  }

  /// Type containing all the content displayed by the pill button.
  struct Content {
    let label: String
    let leadingIcon: String?
    let trailingIcon: String?
    let action: (() -> Void)?
    let type: ButtonType

    /// Creates a new content model for the component.
    /// - Parameters:
    ///   - label: The text displayed in the button.
    ///   - leadingIcon: The name of the icon displayed on the left.
    ///   - trailingIcon: The name of the icon displayed on the right.
    ///   - action: The action which should be perfromed when the user taps on the button.
    ///   - state: The state of the button
    public init(
      label: String,
      leadingIcon: String? = nil,
      trailingIcon: String? = nil,
      action: (() -> Void)? = nil,
      type: ButtonType = .idle
    ) {
      self.label = label
      self.leadingIcon = leadingIcon
      self.trailingIcon = trailingIcon
      self.action = action
      self.type = type
    }
  }
}
