//
//  MenuListCell.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 02.11.2025.
//

import SwiftUI

/// Type indicating a list element which can be used in multiple contexts.
public struct MenuListCell: View {
  // MARK: - Observed Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let content: Content

  // MARK: - Init

  /// Creates a new profile `MenuListCell`.
  /// - Parameter content: The content model of the component.
  public init(content: Content) {
    self.content = content
  }

  // MARK: - Body

  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      HStack(alignment: .top) {
        title
        Spacer()
        performance
      }
      .padding(.bottom, theme.spacing.spacerM)
      HStack {
        subtitle
        Spacer()
      }
      .padding(.bottom, theme.spacing.spacerXL)
      HStack {
        leadingButtons
        Spacer()
        trailingButtons
      }
    }
    .padding(.horizontal, theme.spacing.spacerL)
    .padding(.vertical, theme.spacing.spacerXL)
    .background(theme.colorPalette.surface.primary)
    .clipShape(roundingShape)
    .overlay {
      borderView
    }
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
  }

  // MARK: - Subviews

  private var title: some View {
    Text(content.title)
      .foregroundStyle(theme.colorPalette.text.primary)
      .font(theme.typography.title.headline)
  }

  @ViewBuilder private var subtitle: some View {
    HStack(spacing: theme.spacing.spacerS) {
      if let icon = content.subtitle.icon {
        Image(systemName: icon)
          .resizable()
          .foregroundStyle(theme.colorPalette.icon.secondary)
          .frame(width: theme.iconSize.iconXS, height: theme.iconSize.iconXS)
      }
      Text(content.subtitle.label)
        .foregroundStyle(theme.colorPalette.text.secondary)
        .font(theme.typography.body.footnote)
    }
  }

  @ViewBuilder private var performance: some View {
    if let performance = content.performance {
      Text(performance.label)
        .foregroundStyle(makePerformanceColor(performance: performance))
        .font(theme.typography.body.subheadline)
    }
  }

  private var leadingButtons: some View {
    HStack(spacing: theme.spacing.spacerS) {
      ForEach(content.leadingButtons.indices, id: \.self) { index in
        PillButton(content: content.leadingButtons[index])
      }
    }
  }

  private var trailingButtons: some View {
    HStack(spacing: theme.spacing.spacerS) {
      ForEach(content.trailingButtons.indices, id: \.self) { index in
        PillButton(content: content.trailingButtons[index])
      }
    }
  }

  private func  makePerformanceColor(performance: Performance) -> Color {
    switch performance.type {
    case .positive:
      theme.colorPalette.text.positive
    case .neutral:
      theme.colorPalette.text.primary
    case .negative:
      theme.colorPalette.text.negative
    }
  }

  private var roundingShape: some Shape {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusXXL)
  }

  @ViewBuilder private var borderView: some View {
    roundingShape
      .stroke(theme.colorPalette.icon.disabled, lineWidth: theme.spacing.lineWidth)
  }
}

// MARK: - Content Model

public extension MenuListCell {
  /// Type indicating how the performance of the value is displayed in the cell.
  enum PerformanceType {
    /// Marked by a green value
    case positive
    /// Marked by a red value
    case negative
    /// Marked by a text with the default color
    case neutral
  }

  /// Type indicating the content of the performance value displayed in the cell(by default at the top right).
  struct Performance {
    let label: String
    let type: PerformanceType

    public init(label: String, type: PerformanceType) {
      self.label = label
      self.type = type
    }
  }

  /// Type indicating the content of the subtitle section.
  struct Subtitle {
    let label: String
    let icon: String?

    public init(label: String, icon: String?) {
      self.label = label
      self.icon = icon
    }
  }

  /// Type representing the content model of the component.
  struct Content {
    let title: String
    let subtitle: Subtitle
    let performance: Performance?
    let leadingButtons: [PillButton.Content]
    let trailingButtons: [PillButton.Content]

    /// Createsa new content model for the component.
    /// - Parameters:
    ///   - title: The title of the cell.
    ///   - subtitle: The content of the subtitle field
    ///   - performance: The configuration for the performance.
    ///   - leadingButtons: List of pill buttons displayed in the bottom left part of the cell.
    ///   - trailingButtons: ist of pill buttons displayed in the bottom right part of the cell.
    public init(
      title: String,
      subtitle: Subtitle,
      performance: Performance?,
      leadingButtons: [PillButton.Content],
      trailingButtons: [PillButton.Content]
    ) {
      self.title = title
      self.subtitle = subtitle
      self.performance = performance
      self.leadingButtons = leadingButtons
      self.trailingButtons = trailingButtons
    }
  }
}
