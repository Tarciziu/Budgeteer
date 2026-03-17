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

  @Injected(\.remindersInteractor)
  private var remindersInteractor

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
    let remindersViewModel = RemindersListViewModel(interactor: remindersInteractor)
    let closeAction = NavigationBarConfiguration.CloseAction(
      icon: theme.imageCatalog.uiAction.chevronLeft
    ) { [weak self] in
      self?.navigationController.popViewController(animated: true)
    }
    let addAction = NavigationBarConfiguration.CloseAction(
      icon: theme.imageCatalog.uiActionCircle.plusCircle
    ) { [weak self] in
      self?.navigateToReminderConfigPage()
    }
    let navigationBarConfiguration = NavigationBarConfiguration(
      title: "Reminders page",
      leadingAction: closeAction,
      trailingAction: addAction
    )
    return RemindersList(viewModel: remindersViewModel, navigationBar: navigationBarConfiguration)
  }

  private func navigateToReminderConfigPage() {
    let reminderConfigurationPage = assembleReminderConfigurationPage()
    let hostingController = BTHostingController(containedView: reminderConfigurationPage)
    let reminderConfigNavigationController = BTNavigationController()
    reminderConfigNavigationController.viewControllers = [hostingController]
    navigationController.present(reminderConfigNavigationController, animated: true)
  }

  private func assembleReminderConfigurationPage() -> ReminderConfigurationPage {
    let reminderConfigurationViewModel = ReminderConfigurationViewModel(interactor: remindersInteractor)

    let closeAction = NavigationBarConfiguration.CloseAction(
      icon: theme.imageCatalog.uiActionCircle.closeCircle
    ) { [weak self] in
      self?.closeReminderConfigurationPage()
    }

    let navigationBarConfiguration = NavigationBarConfiguration(
      title: "Add reminder", // Will be updated later
      leadingAction: nil,
      trailingAction: closeAction
    )
    return ReminderConfigurationPage(
      viewModel: reminderConfigurationViewModel,
      navigationBarConfiguration: navigationBarConfiguration
    )
  }

  private func closeReminderConfigurationPage() {
    navigationController.dismiss(animated: true)
  }
}
