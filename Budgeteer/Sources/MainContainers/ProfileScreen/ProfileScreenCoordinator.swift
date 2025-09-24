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
    let profileScreen = ProfileScreen(config: navigationBarConfiguration)
    let hostingController = BTHostingController(containedView: profileScreen)
    navigationController.viewControllers = [hostingController]
  }
}
