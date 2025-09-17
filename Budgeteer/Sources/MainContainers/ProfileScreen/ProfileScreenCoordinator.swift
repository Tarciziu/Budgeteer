//
//  ProfileScreenCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import Foundation
import BTCoreUI
import FactoryKit

class ProfileScreenCoordinator {
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
      title: "Profile Screen",
      action: nil
    )
    let homeScreen = HomeScreen(config: navigationBarConfiguration)
    let hostingController = BTHostingController(containedView: homeScreen)
    navigationController.viewControllers = [hostingController]
  }
}
