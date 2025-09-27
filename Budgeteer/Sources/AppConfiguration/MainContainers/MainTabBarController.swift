//
//  RootViewController.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2025.
//

import UIKit
import SwiftUI
import BTCore
import BTCoreUI

class MainTabBarController: UITabBarController {
  // MARK: - UITabBarController Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    assembleTabs()
  }

  // MARK: - Private Methods

  private func assembleTabs() {
    viewControllers = [
      assembleHomeScreen(),
      assembleTransactionsScreen(),
      assembleProfileScreen()
    ]
  }

  private func assembleHomeScreen() -> UINavigationController {
    let navigationController = BTNavigationController()
    let coordinator = HomeScreenCoordinator(navigationController: navigationController)
    navigationController.tabBarItem = UITabBarItem(
      title: Strings.Budgeteer.singular("tabBar.home.title"),
      image: UIImage(systemName: "house"),
      selectedImage: UIImage(systemName: "house.fill")
    )
    coordinator.start()
    return navigationController
  }

  private func assembleTransactionsScreen() -> UINavigationController {
    let navigationController = BTNavigationController()
    let coordinator = TransactionsCoordinator(navigationController: navigationController)
    navigationController.tabBarItem = UITabBarItem(
      title: Strings.Budgeteer.singular("tabBar.transactions.title"),
      image: UIImage(systemName: "long.text.page.and.pencil"),
      selectedImage: UIImage(systemName: "long.text.page.and.pencil.fill")
    )
    coordinator.start()
    return navigationController
  }

  private func assembleProfileScreen() -> UINavigationController {
    let navigationController = BTNavigationController()
    let coordinator = ProfileScreenCoordinator(navigationController: navigationController)
    navigationController.tabBarItem = UITabBarItem(
      title: Strings.Budgeteer.singular("tabBar.profile.title"),
      image: UIImage(systemName: "person"),
      selectedImage: UIImage(systemName: "person.fill")
    )
    coordinator.start()
    return navigationController
  }
}
