//
//  ChipButton.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 29/04/2026.
//

import SwiftUI

/// Reusable component representing a toggleable chip button.
public struct ChipButton: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let content: Content

  // MARK: - Initializer

  /// Creates a new chip button.
  /// - Parameter content: The content model used by the component.
  public init(content: Content) {
    self.content = content
  }

  // MARK: - Body

  @ViewBuilder public var body: some View {
    if content.isSelected {
      Button { content.action() } label: { chipLabel }
        .buttonStyle(.glassProminent)
    } else {
      Button { content.action() } label: { chipLabel }
        .buttonStyle(.glass)
    }
  }

  // MARK: - Subviews

  private var chipLabel: some View {
    HStack(spacing: theme.spacing.spacerXS) {
      Text(content.label)
        .font(theme.typography.body.footnote)
      if let trailingIcon = content.trailingIcon {
        Image(systemName: trailingIcon)
          .resizable()
          .renderingMode(.template)
          .frame(width: theme.iconSize.iconXXS, height: theme.iconSize.iconXXS)
      }
    }
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
  }
}

// MARK: - Content Model

public extension ChipButton {
  /// Type containing all the content displayed by the chip button.
  struct Content {
    let label: String
    let isSelected: Bool
    let trailingIcon: String?
    let action: () -> Void

    /// Creates a new content model for the component.
    /// - Parameters:
    ///   - label: The text displayed in the chip.
    ///   - isSelected: Whether the chip is in the selected state.
    ///   - trailingIcon: Optional system image name displayed after the label.
    ///   - action: The action performed when the user taps on the chip.
    public init(
      label: String,
      isSelected: Bool,
      trailingIcon: String? = nil,
      action: @escaping () -> Void
    ) {
      self.label = label
      self.isSelected = isSelected
      self.trailingIcon = trailingIcon
      self.action = action
    }
  }
}
