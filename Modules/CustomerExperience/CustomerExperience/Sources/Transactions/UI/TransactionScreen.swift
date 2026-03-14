//
//  TransactionScreen.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 14.03.2026.
//

import SwiftUI
import BTCoreUI

/// Screen providing information about an existing transaction or the template for a new transaction.
public struct TransactionScreen: View {
  // MARK: Environment

  @Environment(\.dismiss)
  private var dismiss

  // MARK: - Init

  /// Initializes a new ``TransactionScreen``.
  public init() {}

  // MARK: - Body

  public var body: some View {
    Text("Transaction screen")
      .navigationBar(makeConfiguration())
  }

  // MARK: - Navigation Configuration

  private func makeConfiguration() -> NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(icon: "xmark") {
      // TODO: Handle dismiss action
    }
    return NavigationBarConfiguration(
      title: "transactionScreen.title",
      trailingAction: trailingAction
    )
  }
}
