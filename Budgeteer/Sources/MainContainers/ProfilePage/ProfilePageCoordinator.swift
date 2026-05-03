//
//  ProfileScreenCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import Combine

import BTCore
import BTCoreUI

import UIKit

class ProfilePageCoordinator {
  // MARK: - Private Properties

  private let navigationController: BTNavigationController
  private var profilePageSubscription: AnyCancellable?

  private let feedbackCoordinator: FeedbackCoordinator
  private let themeCustomizationCoordinator: ThemeCustomizationCoordinator
  private let remindersCoordinator: RemindersCoordinator

  // MARK: - Init

  init(navigationController: BTNavigationController) {
    self.navigationController = navigationController
    self.feedbackCoordinator = FeedbackCoordinator(
      navigationController: navigationController
    )
    self.themeCustomizationCoordinator = ThemeCustomizationCoordinator(
      navigationController: navigationController
    )
    self.remindersCoordinator = RemindersCoordinator(navigationController: navigationController)
  }

  // MARK: - Internal Methods

  func start() {
    let profilePage = assembleProfilePage()
    let hostingController = BTHostingController(containedView: profilePage)
    navigationController.viewControllers = [hostingController]
  }

  // MARK: - Private Methods

  private func assembleProfilePage() -> ProfilePage {
    let viewModel = ProfilePageViewModel()
    observe(viewModel)
    let navigationBarConfiguration = NavigationBarConfiguration(title: "Profile Screen")
    return ProfilePage(viewModel: viewModel, config: navigationBarConfiguration)
  }

  private func observe(_ viewModel: ProfilePageViewModel) {
    profilePageSubscription = viewModel.eventsPublisher.sink { [weak self] event in
      switch event {
      case .externalNavigation(let destination):
        self?.handleExternalNavigation(url: destination)
      case .internalNavigation(let destination):
        self?.handleInternalNavigation(destination)
      }
    }
  }

  private func handleExternalNavigation(url: URL) {
    UIApplication.shared.open(url)
  }

  private func handleInternalNavigation(
    _ internalDestination: ProfilePageViewModel.InternalNavigationDestination
  ) {
    switch internalDestination {
    case .reminders:
      remindersCoordinator.start()
    case .themeCustomization:
      themeCustomizationCoordinator.start()
    case .feedback:
      feedbackCoordinator.start()
    }
  }
}

extension ProfilePageCoordinator {
  func process(_ event: LocalNotificationEvent) {
    // TODO: - Add Handling when necessary
  }
}
