//
//  SelectionListCell.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import SwiftUI

/// Type representing a tappable list row used to pick one option out of a list. It shows a label and
/// an optional trailing icon (typically a checkmark on the selected row), with an optional divider
/// below.
public struct SelectionListCell: View {
  // MARK: - Observed Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let content: Content

  // MARK: - Init

  /// Creates a new `SelectionListCell`.
  /// - Parameter content: The content model of the component.
  public init(content: Content) {
    self.content = content
  }

  // MARK: - Body

  public var body: some View {
    Button {
      content.action()
    } label: {
      cellContent
    }
  }

  // MARK: - Subviews

  private var cellContent: some View {
    VStack(spacing: .zero) {
      HStack(spacing: theme.spacing.spacerM) {
        title
        Spacer(minLength: theme.spacing.spacerM)
        trailingIcon
      }
      .padding(theme.spacing.spacerL)
      if content.hasDivider {
        RegularDivider()
      }
    }
    .contentShape(.rect)
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
  }

  private var title: some View {
    Text(content.label)
      .font(theme.typography.body.body)
      .foregroundStyle(theme.colorPalette.text.primary)
  }

  @ViewBuilder private var trailingIcon: some View {
    if let icon = content.trailingIcon {
      Image(systemName: icon)
        .font(theme.typography.body.bodyBold)
        .foregroundStyle(theme.colorPalette.tint.primary)
    }
  }
}

// MARK: - Content Model

public extension SelectionListCell {
  /// Type containing all the content displayed by the component.
  struct Content {
    let label: String
    let trailingIcon: String?
    let hasDivider: Bool
    let action: () -> Void

    /// Creates a new content model for the component.
    /// - Parameters:
    ///   - label: The text displayed in the row.
    ///   - trailingIcon: Optional system image name displayed at the trailing edge, e.g. a checkmark
    ///     on the selected row. Pass `nil` to hide it.
    ///   - hasDivider: Whether a divider is shown below the row.
    ///   - action: The action performed when the user taps on the row.
    public init(
      label: String,
      trailingIcon: String? = nil,
      hasDivider: Bool = false,
      action: @escaping () -> Void
    ) {
      self.label = label
      self.trailingIcon = trailingIcon
      self.hasDivider = hasDivider
      self.action = action
    }
  }
}
