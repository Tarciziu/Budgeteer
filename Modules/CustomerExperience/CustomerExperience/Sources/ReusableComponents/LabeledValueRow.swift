//
//  LabeledValueRow.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import SwiftUI
import BTCoreUI

/// A caption label above a bordered, rounded row that shows a value on the left and a
/// trailing disclosure chevron — a read-only "tap to change" field.
public struct LabeledValueRow: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  private let label: String
  private let value: String

  // MARK: - Init

  /// Creates a new `LabeledValueRow`.
  /// - Parameters:
  ///   - label: The caption shown above the row.
  ///   - value: The value shown inside the row.
  public init(label: String, value: String) {
    self.label = label
    self.value = value
  }

  // MARK: - Body

  public var body: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerXS) {
      Text(label)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
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
}
