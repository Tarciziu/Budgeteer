//
//  RootViewController.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2025.
//

import Foundation
import UIKit
import SwiftUI

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
    let embeddedView = HomeScreen()
    let hostingController = UIHostingController(rootView: embeddedView)
    let navigationController = UINavigationController(rootViewController: hostingController)
    navigationController.tabBarItem = UITabBarItem(
      title: "Home",
      image: UIImage(systemName: "house"),
      selectedImage: UIImage(systemName: "house.fill")
    )
    return navigationController
  }

  private func assembleTransactionsScreen() -> UINavigationController {
    let embeddedView = TransactionsScreen()
    let hostingController = UIHostingController(rootView: embeddedView)
    let navigationController = UINavigationController(rootViewController: hostingController)
    navigationController.tabBarItem = UITabBarItem(
      title: "Transactions",
      image: UIImage(systemName: "long.text.page.and.pencil"),
      selectedImage: UIImage(systemName: "long.text.page.and.pencil.fill")
    )
    return navigationController
  }

  private func assembleProfileScreen() -> UINavigationController {
    let embeddedView = ProfileScreen()
    let hostingController = UIHostingController(rootView: embeddedView)
    let navigationController = UINavigationController(rootViewController: hostingController)
    navigationController.tabBarItem = UITabBarItem(
      title: "Profile",
      image: UIImage(systemName: "person"),
      selectedImage: UIImage(systemName: "person.fill")
    )
    return navigationController
  }
}
