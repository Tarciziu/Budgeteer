//
//  AccountCard.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 18/08/2026.
//

import SwiftUI

public struct AccountCard: View {
  // MARK: - Nested Types

  private enum Constants {
    static let loadingString = "Loading..."
  }

  // MARK: - Environment

  @Environment(BTTheme.self)
  private var theme
  @Environment(\.isEnabled)
  private var isEnabled
  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let label: String
  private let title: String
  private let caption: String?
  private let isSelected: Bool

  // MARK: - Initializer

  /// Initializes a new ``AccountCard``.
  /// - Parameters:
  ///   - label: String representing the label displayed on the first line of the card.
  ///   - title: String representing the title of the card.
  ///   - caption: String representing the caption of the card
  ///   - isSelected: Boolean representing the selected state of the card.
  public init(label: String, title: String, caption: String? = nil, isSelected: Bool = false) {
    self.label = label
    self.title = title
    self.caption = caption
    self.isSelected = isSelected
  }

  // MARK: - Body

  public var body: some View {
    if isLoading {
      loadingView
    } else {
      loadedView
    }
  }

  // MARK: - Loading View

  private var loadingView: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerS) {
      HStack(spacing: .zero) {
        Text(Constants.loadingString)
          .font(theme.typography.title.headline)
          .foregroundStyle(theme.colorPalette.text.primary)
        Spacer()
        Image(systemName: theme.imageCatalog.selection.circleFilled)
          .renderingMode(.template)
          .resizable()
          .foregroundStyle(theme.colorPalette.tint.primary)
          .frame(width: theme.iconSize.iconXS, height: theme.iconSize.iconXS)
          .clipShape(roundingShape)
      }
      Text(Constants.loadingString)
        .font(theme.typography.title.title2)
        .foregroundStyle(theme.colorPalette.text.primary)
      Text(Constants.loadingString)
        .font(theme.typography.body.footnote)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
    .redacted(reason: .placeholder)
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
    .padding(theme.spacing.spacerXL)
    .background(makeBackgroundColor())
    .clipShape(roundingShape)
    .overlay {
      borderView
    }
  }

  // MARK: - Loaded View

  private var loadedView: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerS) {
      labelText
      titleText
      captionText
    }
    .padding(theme.spacing.spacerXL)
    .background(makeBackgroundColor())
    .clipShape(roundingShape)
    .overlay {
      borderView
    }
  }

  private var labelText: some View {
    HStack(spacing: .zero) {
      Text(label)
        .font(theme.typography.title.headline)
        .foregroundStyle(theme.colorPalette.text.primary)
      Spacer()
      imageView
    }
  }

  @ViewBuilder private var imageView: some View {
    if isSelected {
      Image(systemName: theme.imageCatalog.selection.circleFilled)
        .renderingMode(.template)
        .resizable()
        .foregroundStyle(theme.colorPalette.tint.primary)
        .frame(width: theme.iconSize.iconXS, height: theme.iconSize.iconXS)
    }
  }

  private var titleText: some View {
    Text(title)
      .font(theme.typography.title.title2)
      .foregroundStyle(theme.colorPalette.text.primary)
  }

  @ViewBuilder private var captionText: some View {
    if let caption {
      Text(caption)
        .font(theme.typography.body.footnoteBold)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  @ViewBuilder private var borderView: some View {
    roundingShape
      .stroke(makeBorderColor(), lineWidth: theme.spacing.lineWidth)
  }

  private var roundingShape: some Shape {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusXXL)
  }

  // MARK: - Helper Methods

  private func makeBackgroundColor() -> Color {
    if isEnabled {
      return theme.colorPalette.surface.primary
    }
    return theme.colorPalette.surface.secondary
  }

  private func makeBorderColor() -> Color {
    if isSelected {
      return theme.colorPalette.tint.primary
    }
    return theme.colorPalette.text.disabled
  }
}
