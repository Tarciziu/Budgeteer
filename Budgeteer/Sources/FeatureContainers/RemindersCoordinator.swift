//
//  RemindersCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import BTCoreUI
import BTCustomerExperience
import FactoryKit
import Combine


class RemindersCoordinator {
  // MARK: - Injected Properties

  @Injected(\.theme)
  private var theme

  @Injected(\.getRemindersUsecase)
  private var getRemindersUsecase

  @Injected(\.removeReminderUsecase)
  private var removeReminderUsecase

  @Injected(\.createReminderUsecase)
  private var createReminderUsecase

  // MARK: - Private Properties

  private let navigationController: BTNavigationController

  private var cancellables: [AnyCancellable] = []

  private var remindersListViewModel: RemindersListViewModel?

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
    let remindersViewModel = RemindersListViewModel(
      getRemindersUseCase: getRemindersUsecase,
      removeReminderUsecase: removeReminderUsecase
    )
    self.remindersListViewModel = remindersViewModel
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
    let reminderConfigurationViewModel = ReminderConfigurationViewModel(
      initialReminder: nil,
      addReminderUseCase: createReminderUsecase
    )
    observe(reminderConfigurationViewModel)

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

  private func observe(_ viewModel: ReminderConfigurationViewModel) {
    viewModel.outputPublisher.sink { [weak self] event in
      switch event {
      case .didCreateReminder:
        self?.navigationController.dismiss(animated: true)
        self?.remindersListViewModel?.refresh()
      case .didClosePage:
        self?.navigationController.dismiss(animated: true)
      @unknown default:
        return
      }
    }
    .store(in: &cancellables)
  }
}
