//
//  ReusableComponentsSampleScreen.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import SwiftUI
import BTCoreUI
import BTCustomerExperience

struct ReusableComponentsSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        labeledValueRowSection
        highlightCardSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Reusable Components"))
  }

  // MARK: - Labeled Value Row

  private var labeledValueRowSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Labeled Value Row")
      LabeledValueRow(label: "Start date", value: "5 July 2026")
      LabeledValueRow(label: "Currency", value: "RON")
    }
  }

  // MARK: - Highlight Card

  private var highlightCardSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Highlight Card")
      HighlightCard(
        label: "Your budget period",
        value: "5 July – 4 August",
        caption: "30 days · renews automatically every month"
      )
      HighlightCard(
        label: "Current balance",
        value: "3.000 RON",
        caption: "Across 1 account"
      )
    }
  }

  // MARK: - Helpers

  private func sectionLabel(_ text: String) -> some View {
    Text(text)
      .font(theme.typography.title.headline)
      .foregroundStyle(theme.colorPalette.text.primary)
  }
}
