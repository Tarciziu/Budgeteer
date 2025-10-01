//
//  HomeScreenCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import BTCoreUI
import FactoryKit

class HomeScreenCoordinator {
  // MARK: - Private Properties

  private let navigationController: BTNavigationController

  // MARK: - Init

  init(navigationController: BTNavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Internal Methods

  func start() {
    let navigationBarConfiguration = NavigationBarConfiguration(title: "Home Screen")
    let homeScreen = HomeScreen(config: navigationBarConfiguration)
    let hostingController = BTHostingController(containedView: homeScreen)
    navigationController.viewControllers = [hostingController]
  }
}
