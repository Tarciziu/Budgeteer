//
//  RemindersCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import BTCoreUI
import BTCustomerExperience
import FactoryKit

class RemindersCoordinator {
  // MARK: - Injected Properties

  @Injected(\.theme)
  private var theme

  // MARK: - Private Properties

  private let navigationController: BTNavigationController

  // MARK: - Init

  init(navigationController: BTNavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Internal Methods

  func start() {
    let feedbackPage = assembleRemindersPage()
    let hostingController = BTHostingController(containedView: feedbackPage)
    navigationController.pushViewController(hostingController, animated: true)
  }

  // MARK: - Private Methods

  private func assembleRemindersPage() -> RemindersList {
    let remindersRepository = DefaultRemindersListRepository(
      userPreferences: Container.shared.userPreferences()
    )
    let remindersInteractor = DefaultRemindersListInteractor(repository: remindersRepository)
    let remindersViewModel = RemindersListViewModel(interactor: remindersInteractor)
    let closeAction = NavigationBarConfiguration.CloseAction(
      icon: theme.imageCatalog.uiAction.chevronLeft) { [weak self] in
        self?.navigationController.popViewController(animated: true)
    }
    let navigationBarConfiguration = NavigationBarConfiguration(
      title: "Reminders page",
      leadingAction: closeAction
    )
    return RemindersList(viewModel: remindersViewModel, navigationBar: navigationBarConfiguration)
  }
}
