//
//  AccountCardSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 18/08/2026.
//

import SwiftUI
import BTCoreUI

struct AccountCardSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack {
        AccountCard(
          label: "Euro",
          title: "€ 1.000,00",
          caption: "selected",
          isSelected: true
        )
        AccountCard(
          label: "Euro",
          title: "€ 1.000,00",
          caption: "enabled, not selected",
          isSelected: false
        )
        AccountCard(
          label: "Euro",
          title: "€ 1.000,00",
          caption: "disabled, not selected",
          isSelected: false
        )
        .disabled(true)
        AccountCard(
          label: "Euro",
          title: "€ 1.000,00",
          caption: "disabled, selected",
          isSelected: true
        )
        .disabled(true)
        AccountCard(
          label: String(),
          title: String()
        )
        .isLoading(true)
      }
      .padding(.horizontal, 16)
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "AccountCards"))
  }
}
