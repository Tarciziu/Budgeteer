//
//  TransactionsScreen.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2025.
//

import SwiftUI
import BTCoreUI

struct TransactionsScreen: View {
  private let navBarConfig: NavigationBarConfiguration

  init(config: NavigationBarConfiguration) {
    self.navBarConfig = config
  }

  var body: some View {
    Text("Transactions Screen")
      .navigationBar(navBarConfig)
  }
}
