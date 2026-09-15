//
//  OnboardingSuccessUIMapperTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing
import BTBusinessCore

@testable import BTCustomerExperience

struct OnboardingSuccessUIMapperTests {
  // MARK: - Constants

  private enum Constants {
    static let locale = Locale(identifier: "en_US")

    static var calendar: Calendar {
      var calendar = Calendar(identifier: .gregorian)
      calendar.timeZone = .gmt
      return calendar
    }

    static var periodStart: Date {
      calendar.date(from: DateComponents(year: 2023, month: 11, day: 15)) ?? .distantPast
    }

    static var periodEnd: Date {
      calendar.date(from: DateComponents(year: 2023, month: 12, day: 14)) ?? .distantPast
    }

    static var inputPlan: BudgetPlanDM {
      BudgetPlanDataGenerator.budgetPlanDM(
        name: "Familie",
        currency: .eur,
        recurrentBalance: 5_000,
        periodStartDate: periodStart,
        periodEndDate: periodEnd
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

  // MARK: - Private Properties

  private let mapper = OnboardingSuccessUIMapper()

  // MARK: - Tests

  @Test("The success mapper builds the summary rows from the persisted budget plan.")
  func test_Map_ProducesExpectedUIModel() {
    let uiModel = mapper.map(
      plan: Constants.inputPlan,
      calendar: Constants.calendar,
      locale: Constants.locale
    )

    #expect(uiModel == Constants.expectedUIModel)
  }
}
