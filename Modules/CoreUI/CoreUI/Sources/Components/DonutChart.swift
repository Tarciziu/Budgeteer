//
//  DonutChart.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 07.09.2026.
//

import Charts
import SwiftUI

/// A donut chart that renders a list of proportional elements as a ring, with an
/// optional piece of text displayed in the middle.
///
/// The chart is built on top of Swift Charts' ``SectorMark``. Element percentages are
/// normalised across the whole list, so the ring is always completely filled regardless
/// of whether the values sum to `100`.
///
/// Slice colours come from the theme's ``ChartColors`` palette and are assigned by
/// descending share — the largest slice gets ``ChartColors/one`` — cycling through the
/// three palette colours when there are more than three slices.
///
/// When `hasLegend` is `true`, a legend (colour swatch and label per slice) is shown
/// below the ring.
///
/// The ring has no size of its own: it lays out as a square that fills the width it is
/// given. Apply a `.frame(...)` from the call site when a fixed size is required.
public struct DonutChart: View {
  // MARK: - Nested Types

  /// A single slice of the donut.
  public struct Element: Identifiable {
    public let id = UUID()

    /// Descriptive text for the slice.
    public let label: String

    /// The slice's share of the ring. Values are normalised across all elements, so they
    /// need not sum to `100`.
    public let percentage: Double

    /// Creates a new donut slice.
    /// - Parameters:
    ///   - label: Descriptive text for the slice, shown in the legend.
    ///   - percentage: The slice's share of the ring. Normalised across all elements.
    public init(
      label: String,
      percentage: Double
    ) {
      self.label = label
      self.percentage = percentage
    }
  }

  /// A slice paired with the palette colour assigned by its descending percentage rank.
  private struct RankedSlice: Identifiable {
    let element: Element
    let color: Color

    var id: Element.ID { element.id }
  }

  private enum Constants {
    static let innerRadiusRatio: CGFloat = 0.64
    static let angularInset: CGFloat = 2
  }

  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let elements: [Element]
  private let centerText: String?
  private let hasLegend: Bool

  // MARK: - Initializer

  /// Creates a new ``DonutChart``.
  /// - Parameters:
  ///   - elements: The slices to render, each with a label and a percentage share.
  ///     Percentages are normalised so the ring is always full; colours are assigned
  ///     from the theme's ``ChartColors`` palette by descending share.
  ///   - centerText: Optional text displayed in the hole of the donut.
  ///   - hasLegend: When `true`, a legend listing each slice (colour swatch and label) is
  ///     shown below the ring. Defaults to `false`.
  public init(
    elements: [Element],
    centerText: String? = nil,
    hasLegend: Bool = false
  ) {
    self.elements = elements
    self.centerText = centerText
    self.hasLegend = hasLegend
  }

  // MARK: - Computed Properties

  /// The slices paired with a palette colour, assigned by descending percentage share
  /// (largest slice → ``ChartColors/one``) and cycling once the palette is exhausted.
  private var rankedSlices: [RankedSlice] {
    let palette = [
      theme.colorPalette.chart.one,
      theme.colorPalette.chart.two,
      theme.colorPalette.chart.three
    ]
    let rankByID = Dictionary(
      uniqueKeysWithValues: elements
        .sorted { $0.percentage > $1.percentage }
        .enumerated()
        .map { ($0.element.id, $0.offset) }
    )
    return elements.map { element in
      RankedSlice(
        element: element,
        color: palette[(rankByID[element.id] ?? 0) % palette.count]
      )
    }
  }

  // MARK: - Body

  public var body: some View {
    if hasLegend {
      VStack(spacing: theme.spacing.spacerM) {
        ring
        legend
      }
    } else {
      ring
    }
  }

  // MARK: - Subviews

  private var ring: some View {
    content
      .aspectRatio(1, contentMode: .fit)
  }

  @ViewBuilder private var content: some View {
    if isLoading {
      loadingView
    } else {
      loadedView
    }
  }

  private var legend: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerXS) {
      ForEach(rankedSlices) { slice in
        HStack(spacing: theme.spacing.spacerS) {
          Circle()
            .fill(slice.color)
            .frame(width: theme.iconSize.iconXXS, height: theme.iconSize.iconXXS)
          Text(slice.element.label)
            .font(theme.typography.body.footnote)
            .foregroundStyle(theme.colorPalette.text.secondary)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
  }

  private var loadedView: some View {
    Chart(rankedSlices) { slice in
      SectorMark(
        angle: .value(slice.element.label, slice.element.percentage),
        innerRadius: .ratio(Constants.innerRadiusRatio),
        angularInset: Constants.angularInset
      )
      .cornerRadius(theme.borderRadius.radiusXS)
      .foregroundStyle(slice.color)
    }
    .chartLegend(.hidden)
    .chartBackground { proxy in
      centerLabel(proxy: proxy)
    }
  }

  @ViewBuilder
  private func centerLabel(proxy: ChartProxy) -> some View {
    if let centerText {
      GeometryReader { geometry in
        if let plotAnchor = proxy.plotFrame {
          let plotFrame = geometry[plotAnchor]
          Text(centerText)
            .font(theme.typography.title.headline)
            .foregroundStyle(theme.colorPalette.text.primary)
            .position(x: plotFrame.midX, y: plotFrame.midY)
        }
      }
    }
  }

  private var loadingView: some View {
    GeometryReader { geometry in
      let ringWidth = min(geometry.size.width, geometry.size.height)
        * (1 - Constants.innerRadiusRatio) / 2
      Circle()
        .strokeBorder(theme.colorPalette.surface.secondary, lineWidth: ringWidth)
        .redacted(reason: .placeholder)
        .shimmer(style: ShimmerStyle(theme: theme), active: true)
    }
  }
}
