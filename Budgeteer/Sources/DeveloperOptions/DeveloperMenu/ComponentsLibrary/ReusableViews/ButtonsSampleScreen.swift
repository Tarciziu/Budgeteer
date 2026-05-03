//
//  ButtonsSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import SwiftUI
import BTCoreUI

struct ButtonsSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        regularButtonsSection
        pillButtonsSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Buttons"))
  }

  // MARK: - Regular Buttons

  private var regularButtonsSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Regular Buttons")
      RegularButton(type: .primary, text: "Primary", imageName: nil) {}
      RegularButton(type: .secondary, text: "Secondary", imageName: nil) {}
      RegularButton(type: .primary, text: "With Icon", imageName: "plus") {}
    }
  }

  // MARK: - Pill Buttons

  private var pillButtonsSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Pill Buttons")
      HStack(spacing: theme.spacing.spacerM) {
        PillButton(content: .init(label: "Idle", type: .idle))
        PillButton(content: .init(label: "Highlight", type: .highlight))
        PillButton(content: .init(label: "Error", type: .error))
      }
      HStack(spacing: theme.spacing.spacerM) {
        PillButton(content: .init(label: "Leading", leadingIcon: "arrow.left", type: .idle))
        PillButton(content: .init(label: "Trailing", trailingIcon: "arrow.right", type: .highlight))
      }
    }
  }

  // MARK: - Helpers

  private func sectionLabel(_ text: String) -> some View {
    Text(text)
      .font(theme.typography.title.headline)
      .foregroundStyle(theme.colorPalette.text.primary)
  }
}
