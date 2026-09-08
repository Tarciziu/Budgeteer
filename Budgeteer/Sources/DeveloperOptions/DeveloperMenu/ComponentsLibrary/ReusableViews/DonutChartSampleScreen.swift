//
//  DonutChartSampleScreen.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 07.09.2026.
//

import SwiftUI
import BTCoreUI

struct DonutChartSampleScreen: View {
  // MARK: - Nested Types

  private enum Constants {
    static let referenceSize: CGFloat = 140
    static let largeSize: CGFloat = 240
  }

  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Computed Properties

  private var sampleElements: [DonutChart.Element] {
    [
      DonutChart.Element(label: "Groceries", percentage: 50),
      DonutChart.Element(label: "Shopping", percentage: 30),
      DonutChart.Element(label: "Dining", percentage: 19)
    ]
  }

  private var cyclingElements: [DonutChart.Element] {
    [
      DonutChart.Element(label: "Rent", percentage: 40),
      DonutChart.Element(label: "Groceries", percentage: 25),
      DonutChart.Element(label: "Transport", percentage: 20),
      DonutChart.Element(label: "Subscriptions", percentage: 15)
    ]
  }

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        legendSection
        plainSection
        cyclingSection
        scalesSection
        loadingSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Donut Chart"))
  }

  // MARK: - Sections

  private var legendSection: some View {
    section("With legend") {
      DonutChart(elements: sampleElements, centerText: "€103", hasLegend: true)
        .frame(width: Constants.referenceSize)
    }
  }

  private var plainSection: some View {
    section("Without legend") {
      DonutChart(elements: sampleElements, centerText: "€103")
        .frame(width: Constants.referenceSize, height: Constants.referenceSize)
    }
  }

  private var cyclingSection: some View {
    section("Palette cycling (4 slices)") {
      DonutChart(elements: cyclingElements, hasLegend: true)
        .frame(width: Constants.referenceSize)
    }
  }

  private var scalesSection: some View {
    section("Fills the frame it is given") {
      DonutChart(elements: sampleElements, centerText: "€103")
        .frame(width: Constants.largeSize, height: Constants.largeSize)
    }
  }

  private var loadingSection: some View {
    section("Loading") {
      DonutChart(elements: sampleElements, centerText: "€103", hasLegend: true)
        .frame(width: Constants.referenceSize)
        .isLoading(true)
    }
  }

  // MARK: - Helpers

  private func section(
    _ title: String,
    @ViewBuilder content: () -> some View
  ) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      Text(title)
        .font(theme.typography.title.headline)
        .foregroundStyle(theme.colorPalette.text.primary)
      content()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
