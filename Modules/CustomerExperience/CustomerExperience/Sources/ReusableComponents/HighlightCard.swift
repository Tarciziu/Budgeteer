//
//  HighlightCard.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import SwiftUI
import BTCoreUI

/// A bordered, rounded card that highlights a single value: a small label, a large
/// tinted value, and a supporting caption.
public struct HighlightCard: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  private let label: String
  private let value: String
  private let caption: String

  // MARK: - Init

  /// Creates a new `HighlightCard`.
  /// - Parameters:
  ///   - label: The small caption shown above the value.
  ///   - value: The highlighted value, rendered large and tinted.
  ///   - caption: The supporting text shown below the value.
  public init(label: String, value: String, caption: String) {
    self.label = label
    self.value = value
    self.caption = caption
  }

  // MARK: - Body

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerS) {
      Text(label)
        .font(theme.typography.caption.caption1Bold)
        .foregroundStyle(theme.colorPalette.text.secondary)
      Text(value)
        .font(theme.typography.title.title2)
        .foregroundStyle(theme.colorPalette.tint.primary)
      Text(caption)
        .font(theme.typography.body.footnote)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(theme.spacing.spacerL)
    .background(theme.colorPalette.surface.primary)
    .clipShape(.rect(cornerRadius: theme.borderRadius.radiusXXL))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusXXL)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
  }
}
