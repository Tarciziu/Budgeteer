//
//  OnboardingCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Combine
import UIKit
import BTCoreUI
import BTCustomerExperience

/// Drives the onboarding flow: welcome carousel → account → budget period → success.
///
/// The steps are pushed onto the root navigation controller. When the user reaches the
/// end, `onFinished` is invoked so the app can persist completion and switch to the main
/// phase.
final class OnboardingCoordinator {
  // MARK: - Internal Properties

  var cancellables: [AnyCancellable] = []

  // MARK: - Private Properties

  private let navigationController: BTNavigationController
  private let onFinished: () -> Void

  /// Presentation-only state carried between steps so the success screen can echo it back.
  private(set) var selections: OnboardingSelections = .placeholder

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

  func showBudgetPeriodStep(with draft: OnboardingAccountViewModel.Draft) {
    selections.accountName = draft.name
    selections.startingBalance = draft.startingBalance
    selections.currencyCode = draft.currencyCode
    push(makeBudgetPeriodScreen())
  }

  func showSuccessStep() {
    navigationController.setNavigationBarHidden(true, animated: true)
    push(makeSuccessScreen())
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
