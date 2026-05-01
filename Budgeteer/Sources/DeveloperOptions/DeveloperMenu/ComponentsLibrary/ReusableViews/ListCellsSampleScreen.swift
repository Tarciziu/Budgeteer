//
//  ListCellsSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import SwiftUI
import BTCoreUI

struct ListCellsSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        valueListCellSection
        navigationListCellSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "List Cells"))
  }

  // MARK: - Value List Cells

  private var valueListCellSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Value List Cells")
      ValueListCell(content: .init(
        leadingContent: .init(title: "Salary", caption: "Monthly income"),
        trailingContent: .init(title: "+$3,500", titleState: .positive, caption: "Apr 2026"),
        hasDivider: true
      ))
      ValueListCell(content: .init(
        leadingContent: .init(title: "Rent", caption: "Housing expense"),
        trailingContent: .init(title: "-$1,200", titleState: .negative, caption: "Apr 2026"),
        hasDivider: true
      ))
      ValueListCell(content: .init(
        leadingContent: .init(
          avatar: Avatar(content: .text("G"), size: .small, shape: .circle, hasBorder: true),
          title: "Groceries",
          caption: "Weekly"
        ),
        trailingContent: .init(title: "$85.50", titleState: .neutral)
      ))
    }
  }

  // MARK: - Navigation List Cells

  private var navigationListCellSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Navigation List Cells")
      NavigationListCell(
        content: .init(
          icon: "gearshape",
          title: "Settings",
          caption: "App preferences",
          navigationIcon: .default,
          hasDivider: true
        )
      )
      NavigationListCell(
        content: .init(
          icon: "bell",
          title: "Notifications",
          navigationIcon: .default,
          hasDivider: true
        )
      )
      NavigationListCell(
        content: .init(
          icon: "questionmark.circle",
          title: "Help & Support",
          navigationIcon: .custom("arrow.up.right"),
          hasDivider: true
        )
      )
      NavigationListCell(
        content: .init(icon: nil, title: "No Icon Cell", navigationIcon: .none)
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
