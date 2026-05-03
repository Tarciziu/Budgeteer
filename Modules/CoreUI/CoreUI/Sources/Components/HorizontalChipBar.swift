//
//  HorizontalChipBar.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 29/04/2026.
//

import SwiftUI

/// Reusable component representing a horizontally scrollable bar of chip buttons.
public struct HorizontalChipBar: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  private let pinnedChips: [ChipButton.Content]
  private let chips: [ChipButton.Content]

  // MARK: - Initializer

  /// Creates a new horizontal chip bar.
  /// - Parameters:
  ///   - pinnedChips: Chip buttons pinned to the leading edge, outside the scrollable area.
  ///   - chips: The scrollable chip button content models to display.
  public init(
    pinnedChips: [ChipButton.Content] = [],
    chips: [ChipButton.Content]
  ) {
    self.pinnedChips = pinnedChips
    self.chips = chips
  }

  // MARK: - Body

  public var body: some View {
    HStack(spacing: theme.spacing.spacerS) {
      ForEach(Array(pinnedChips.enumerated()), id: \.offset) { _, chip in
        ChipButton(content: chip)
      }
      ScrollView(.horizontal) {
        HStack(spacing: theme.spacing.spacerS) {
          ForEach(Array(chips.enumerated()), id: \.offset) { _, chip in
            ChipButton(content: chip)
          }
        }
      }
      .scrollIndicators(.hidden)
    }
    .padding(.horizontal, theme.spacing.spacerL)
  }
}
