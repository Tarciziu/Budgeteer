//
//  OnboardingCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Combine
import UIKit
import FactoryKit
import BTCoreUI
import BTBusinessCore
import BTCustomerExperience

/// Drives the onboarding flow: welcome carousel → account → budget period → success.
///
/// The steps are pushed onto the root navigation controller. When the user reaches the
/// end, `onFinished` is invoked so the app can persist completion and switch to the main
/// phase.
final class OnboardingCoordinator {
  // MARK: - Injected Properties

  @Injected(\.createInitialPlanUseCase)
  var createInitialPlanUseCase

  // MARK: - Internal Properties

  var cancellables: [AnyCancellable] = []

  /// Accumulates the values entered across the steps; the account step writes into it and the
  /// budget-period step builds and persists the plan from it.
  let dataProvider = OnboardingSelectionDataProvider()

  // MARK: - Private Properties

  private let navigationController: BTNavigationController
  private let onFinished: () -> Void

  // MARK: - Init

  init(
    navigationController: BTNavigationController,
    onFinished: @escaping () -> Void
  ) {
    self.navigationController = navigationController
    self.onFinished = onFinished
  }

  // MARK: - Deinit

  deinit {
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
  }

  // MARK: - Internal Methods

  func start() {
    // The intro carousel and the success screen are full-bleed; the two form steps
    // in between use the native navigation bar (round back button + step label).
    // Each hosting controller re-asserts its own bar visibility in `viewWillAppear`,
    // so this survives the interactive swipe-back too.
    navigationController.setNavigationBarHidden(true, animated: false)
    navigationController.setViewControllers([makeWelcomeScreen()], animated: false)
  }

  // MARK: - Flow Navigation

  func showAccountStep() {
    navigationController.setNavigationBarHidden(false, animated: true)
    push(makeAccountScreen())
  }

  func showBudgetPeriodStep() {
    push(makeBudgetPeriodScreen())
  }

  func showSuccessStep(with plan: BudgetPlanDM) {
    navigationController.setNavigationBarHidden(true, animated: true)
    push(makeSuccessScreen(plan: plan))
  }

  func goToPreviousStep() {
    navigationController.popViewController(animated: true)
  }

  func finish() {
    onFinished()
  }

  // MARK: - Private Methods

  private func push(_ viewController: UIViewController) {
    navigationController.pushViewController(viewController, animated: true)
  }
}
