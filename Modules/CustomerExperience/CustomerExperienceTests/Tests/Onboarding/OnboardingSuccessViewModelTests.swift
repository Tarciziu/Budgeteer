//
//  OnboardingSuccessViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing
import Combine
import BTBusinessCore

@testable import BTCustomerExperience

struct OnboardingSuccessViewModelTests {
  // MARK: - Constants

  private enum Constants {
    static let locale = Locale(identifier: "en_US")

    static var calendar: Calendar {
      var calendar = Calendar(identifier: .gregorian)
      calendar.timeZone = .gmt
      return calendar
    }

    static var inputPlan: BudgetPlanDM {
      BudgetPlanDataGenerator.budgetPlanDM(
        name: "Familie",
        currency: .eur,
        recurrentBalance: 5_000,
        periodStartDate: calendar.date(from: DateComponents(year: 2023, month: 11, day: 15)) ?? .distantPast,
        periodEndDate: calendar.date(from: DateComponents(year: 2023, month: 12, day: 14)) ?? .distantPast
      )
    }

    static let expectedUIModel = OnboardingSuccessUIModel(
      title: "You're all set!",
      subtitle: "Your account is ready to use. You can change the currency or budget period anytime from settings.",
      rows: [
        OnboardingSuccessUIModel.Row(label: "Account", value: "Familie", isHighlighted: false),
        OnboardingSuccessUIModel.Row(label: "Starting balance", value: "5,000.00", isHighlighted: false),
        OnboardingSuccessUIModel.Row(label: "Currency", value: "EUR", isHighlighted: false),
        OnboardingSuccessUIModel.Row(
          label: "Current period",
          value: "Nov 15 – Dec 14",
          isHighlighted: true
        )
      ],
      primaryButtonTitle: "Go to Home"
    )
  }

  // MARK: - UI Model

  @Test("The success summary echoes the persisted budget plan.")
  func test_UIModel_ReflectsPersistedPlan() {
    let viewModel = OnboardingSuccessViewModel(
      plan: Constants.inputPlan,
      calendar: Constants.calendar,
      locale: Constants.locale
    )

    #expect(viewModel.uiModel == Constants.expectedUIModel)
  }

  // MARK: - Behaviour

  @Test("Tapping the primary button emits `.goToHomeRequested`.")
  func test_HandleGoToHomeTap_EmitsGoToHomeRequested() async {
    let viewModel = OnboardingSuccessViewModel(plan: BudgetPlanDataGenerator.budgetPlanDM())
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .goToHomeRequested)
        continuation.resume()
      }

      viewModel.handleGoToHomeTap()
    }

    cancellable?.cancel()
  }
}
