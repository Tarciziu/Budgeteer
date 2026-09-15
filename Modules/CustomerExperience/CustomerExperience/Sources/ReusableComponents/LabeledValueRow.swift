//
//  LabeledValueRow.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import SwiftUI
import BTCoreUI

/// A caption label above a bordered, rounded row that shows a value on the left and a
/// trailing disclosure chevron — a "tap to change" field.
///
/// Pass `action` to make the value box tappable; pass `isExpanded` to rotate the chevron while an
/// attached picker/disclosure is open.
public struct LabeledValueRow: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  private let label: String
  private let value: String
  private let isExpanded: Bool
  private let action: (() -> Void)?

  // MARK: - Init

  /// Creates a new `LabeledValueRow`.
  /// - Parameters:
  ///   - label: The caption shown above the row.
  ///   - value: The value shown inside the row.
  ///   - isExpanded: When `true`, the trailing chevron rotates 90° to point down. Defaults to `false`.
  ///   - action: Invoked when the value box is tapped. When `nil` (default) the row is not tappable.
  public init(
    label: String,
    value: String,
    isExpanded: Bool = false,
    action: (() -> Void)? = nil
  ) {
    self.label = label
    self.value = value
    self.isExpanded = isExpanded
    self.action = action
  }

  // MARK: - Body

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerXS) {
      Text(label)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
      valueBox
    }
  }

  // MARK: - Subviews

  @ViewBuilder private var valueBox: some View {
    if let action {
      Button(action: action) {
        rowContent
      }
      .buttonStyle(.plain)
      .contentShape(.rect)
    } else {
      rowContent
    }
  }

  private var rowContent: some View {
    HStack {
      Text(value)
        .font(theme.typography.body.body)
        .foregroundStyle(theme.colorPalette.text.primary)
      Spacer()
      Image(systemName: theme.imageCatalog.uiAction.chevronRight)
        .resizable()
        .scaledToFit()
        .fontWeight(.semibold)
        .frame(width: theme.spacing.spacerS, height: theme.iconSize.iconS)
        .foregroundStyle(theme.colorPalette.text.secondary)
        .rotationEffect(.degrees(isExpanded ? 90 : 0))
    }
    .padding(theme.spacing.spacerL)
    .frame(maxWidth: .infinity)
    .background(theme.colorPalette.surface.primary)
    .clipShape(.rect(cornerRadius: theme.borderRadius.radiusXL))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusXL)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
  }
}
