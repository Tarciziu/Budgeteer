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
    let profilePage = assembleProfilePage()
    let hostingController = BTHostingController(containedView: profilePage)
    navigationController.viewControllers = [hostingController]
  }

  // MARK: - Private Methods

  private func assembleProfilePage() -> ProfilePage {
    let repository = DefaultProfilePageRepository()
    let interactor = DefaultProfilePageInteractor(repository: repository)
    let viewModel = ProfilePageViewModel(interactor: interactor)
    let navigationBarConfiguration = NavigationBarConfiguration(
      title: "Profile Screen",
      action: nil
    )
    return ProfilePage(viewModel: viewModel, config: navigationBarConfiguration)
  }
}
