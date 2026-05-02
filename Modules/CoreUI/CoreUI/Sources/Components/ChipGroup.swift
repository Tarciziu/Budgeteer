//
//  ChipGroup.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 29/04/2026.
//

import SwiftUI

/// Reusable component representing a labeled group of selectable chips.
public struct ChipGroup: View {
  // MARK: - Nested Types

  private enum Constants {
    static var loadingString: String { "Loading" }
  }

  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let label: String
  private let chips: [ChipButton.Content]

  // MARK: - Initializer

  /// Creates a new chip group.
  /// - Parameters:
  ///   - label: The label displayed above the chip grid.
  ///   - chips: The chip button content models to display.
  public init(
    label: String,
    chips: [ChipButton.Content]
  ) {
    self.label = label
    self.chips = chips
  }

  // MARK: - Body

  public var body: some View {
    contentView
      .frame(maxWidth: .infinity, alignment: .leading)
  }

  // MARK: - Subviews

  @ViewBuilder private var contentView: some View {
    if isLoading {
      loadingContentView
    } else {
      loadedContentView
    }
  }

  private var loadingContentView: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      Text(Constants.loadingString)
        .font(theme.typography.body.subheadline)
      HStack(spacing: theme.spacing.spacerS) {
        Text(Constants.loadingString)
        Text(Constants.loadingString)
        Text(Constants.loadingString)
      }
      .font(theme.typography.body.footnote)
    }
    .redacted(reason: .placeholder)
    .shimmer(style: ShimmerStyle(theme: theme))
  }

  private var loadedContentView: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      labelView
      chipsGridView
    }
    .padding(theme.spacing.spacerL)
  }

  private var labelView: some View {
    VStack(spacing: .zero) {
      Text(label)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
      RegularDivider()
    }
  }

  private var chipsGridView: some View {
    FlowLayout(horizontalSpacing: theme.spacing.spacerS, verticalSpacing: theme.spacing.spacerS) {
      ForEach(Array(chips.enumerated()), id: \.offset) { _, chip in
        ChipButton(content: chip)
      }
    }
  }
}
