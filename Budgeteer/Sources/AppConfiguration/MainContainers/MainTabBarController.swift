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
  // MARK: - Private Properties

  private var profilePageCoordinator: ProfilePageCoordinator?
  private var homeScreenCoordinator: HomeScreenCoordinator?
  private var transacitonsListCoordinator: TransactionsCoordinator?

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
      assembleProfilePage()
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
    homeScreenCoordinator = coordinator
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
    transacitonsListCoordinator = coordinator
    coordinator.start()
    return navigationController
  }

  private func assembleProfilePage() -> UINavigationController {
    let navigationController = BTNavigationController()
    let coordinator = ProfilePageCoordinator(navigationController: navigationController)
    navigationController.tabBarItem = UITabBarItem(
      title: Strings.Budgeteer.singular("tabBar.profile.title"),
      image: UIImage(systemName: "person"),
      selectedImage: UIImage(systemName: "person.fill")
    )
    profilePageCoordinator = coordinator
    coordinator.start()
    return navigationController
  }
}
