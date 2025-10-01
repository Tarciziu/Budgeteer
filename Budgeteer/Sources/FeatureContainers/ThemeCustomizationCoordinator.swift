//
//  ThemeCustomizationCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import BTCoreUI
import BTCustomerExperience
import FactoryKit

class ThemeCustomizationCoordinator {
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
    let feedbackPage = assembleThemeCustomizationPage()
    let hostingController = BTHostingController(containedView: feedbackPage)
    navigationController.pushViewController(hostingController, animated: true)
  }

  // MARK: - Private Methods

  private func assembleThemeCustomizationPage() -> ThemeCustomizationPage {
    let closeAction = NavigationBarConfiguration.CloseAction(
      icon: theme.imageCatalog.uiAction.chevronLeft) { [weak self] in
        self?.navigationController.popViewController(animated: true)
    }
    let navigationBarConfiguration = NavigationBarConfiguration(
      title: "Theme customization page",
      leadingAction: closeAction
    )
    return ThemeCustomizationPage(navigationBar: navigationBarConfiguration)
  }
}
