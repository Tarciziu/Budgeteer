//
//  CardsSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import SwiftUI
import BTCoreUI

struct CardsSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        cardButtonSection
        menuListCellSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Cards"))
  }

  // MARK: - Card Buttons

  private var cardButtonSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Card Buttons")
      HStack(spacing: theme.spacing.spacerM) {
        CardButton(content: .init(title: "Add", icon: "plus.circle")) {}
        CardButton(content: .init(title: "Scan", icon: "qrcode.viewfinder")) {}
        CardButton(content: .init(title: "Export", icon: "square.and.arrow.up")) {}
      }
    }
  }

  // MARK: - Menu List Cells

  private var menuListCellSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Menu List Cells")
      MenuListCell(content: .init(
        title: "Investment Portfolio",
        subtitle: .init(label: "Updated today", icon: "clock"),
        performance: .init(label: "+5.2%", type: .positive),
        leadingButtons: [
          .init(label: "Details", type: .idle)
        ],
        trailingButtons: [
          .init(label: "Trade", type: .highlight)
        ]
      ))
      MenuListCell(content: .init(
        title: "Savings Account",
        subtitle: .init(label: "Low balance warning", icon: "exclamationmark.triangle"),
        performance: .init(label: "-2.1%", type: .negative),
        leadingButtons: [
          .init(label: "Transfer", type: .idle)
        ],
        trailingButtons: [
          .init(label: "Close", type: .error)
        ]
      ))
    }
  }

  // MARK: - Helpers

  private func sectionLabel(_ text: String) -> some View {
    Text(text)
      .font(theme.typography.title.headline)
      .foregroundStyle(theme.colorPalette.text.primary)
  }
}
