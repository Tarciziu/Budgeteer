//
//  OnboardingCoordinator+Screens.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import SwiftUI
import BTCoreUI
import BTBusinessCore
import BTCustomerExperience

extension OnboardingCoordinator {
  // MARK: - Welcome

  func makeWelcomeScreen() -> BTHostingController {
    let viewModel = OnboardingWelcomeViewModel()

    viewModel.eventsPublisher.sink { [weak self] event in
      switch event {
      case .getStarted:
        self?.showAccountStep()
      default:
        return
      }
    }
    .store(in: &cancellables)

    return makeHostingController(for: OnboardingWelcomeScreen(viewModel: viewModel), hidesNavigationBar: true)
  }

  // MARK: - Account

  func makeAccountScreen() -> BTHostingController {
    let viewModel = OnboardingAccountViewModel(dataProvider: dataProvider)

    viewModel.eventsPublisher.sink { [weak self] event in
      switch event {
      case .continueRequested:
        self?.showBudgetPeriodStep()
      default:
        return
      }
    }
    .store(in: &cancellables)

    return makeHostingController(for: OnboardingAccountScreen(viewModel: viewModel), hidesNavigationBar: false)
  }

  // MARK: - Budget Period

  func makeBudgetPeriodScreen() -> BTHostingController {
    let viewModel = OnboardingBudgetPeriodViewModel(
      dataProvider: dataProvider,
      createInitialPlanUseCase: createInitialPlanUseCase
    )

    viewModel.eventsPublisher.sink { [weak self] event in
      switch event {
      case .backRequested:
        self?.goToPreviousStep()
      case let .planCreated(plan):
        self?.showSuccessStep(with: plan)
      default:
        return
      }
    }
    .store(in: &cancellables)

    return makeHostingController(for: OnboardingBudgetPeriodScreen(viewModel: viewModel), hidesNavigationBar: false)
  }

  // MARK: - Success

  func makeSuccessScreen(plan: BudgetPlanDM) -> BTHostingController {
    let viewModel = OnboardingSuccessViewModel(plan: plan)

    viewModel.eventsPublisher.sink { [weak self] event in
      switch event {
      case .goToHomeRequested:
        self?.finish()
      default:
        return
      }
    }
    .store(in: &cancellables)

    return makeHostingController(for: OnboardingSuccessScreen(viewModel: viewModel), hidesNavigationBar: true)
  }

  // MARK: - Helpers

  private func makeHostingController(
    for view: some View,
    hidesNavigationBar: Bool
  ) -> BTHostingController {
    BTHostingController(
      containedView: view,
      config: .init(isNavigationBarHidden: hidesNavigationBar)
    )
  }
}
