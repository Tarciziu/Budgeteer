//
//  TransactionsCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import Foundation
import FactoryKit
import BTCoreUI

class TransactionsCoordinator {
  // MARK: - Private Properties

  private let navigationController: BTNavigationController
  private let theme = Container.shared.theme

  // MARK: - Init

  init(navigationController: BTNavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Internal Methods

  func start() {
    let navigationBarConfiguration = NavigationBarConfiguration(
      title: "Transactions Screen",
      action: nil
    )
    let homeScreen = HomeScreen(config: navigationBarConfiguration)
    let hostingController = BTHostingController(containedView: homeScreen)
    navigationController.viewControllers = [hostingController]
  }
}
