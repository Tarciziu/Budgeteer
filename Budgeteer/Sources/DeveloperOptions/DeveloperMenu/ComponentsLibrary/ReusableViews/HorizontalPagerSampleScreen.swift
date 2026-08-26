//
//  HorizontalPagerSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 18/08/2026.
//

import SwiftUI
import BTCoreUI

struct HorizontalPagerSampleScreen: View {
  struct Account: Hashable, Identifiable {
    let id = UUID().uuidString
    let name: String
    let balance: String
  }

  @Environment(BTTheme.self)
  private var theme
  @State private var selectedItem: Account
  private var items: [Account] = [
    Account(name: "Euros", balance: "€ 1.300,12"),
    Account(name: "Dollar", balance: "$ 1.300,12"),
    Account(name: "Pound", balance: "£ 1.300,12"),
    Account(name: "Pound", balance: "£ 1.300,12")
  ]

  init() {
    selectedItem = items.first ?? Account(name: "Euros", balance: "€ 1.300,12")
  }

  var body: some View {
    VStack {
      HorizontalPagerView(items: items, selectedItem: $selectedItem, hasPageControl: true) { item in
        AccountCard(label: item.name, title: item.balance, isSelected: selectedItem == item)
          .isLoading(item == items.last)
      }
      Spacer()
    }
    .navigationBar(NavigationBarConfiguration(title: "Horizontal Pager"))
  }
}
