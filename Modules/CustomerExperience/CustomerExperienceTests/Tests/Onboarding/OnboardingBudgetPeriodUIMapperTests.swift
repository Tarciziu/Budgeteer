//
//  OnboardingBudgetPeriodUIMapperTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing

@testable import BTCustomerExperience

struct OnboardingBudgetPeriodUIMapperTests {
  // MARK: - Constants

  private enum Constants {
    static let locale = Locale(identifier: "en_US")

    static var calendar: Calendar {
      var calendar = Calendar(identifier: .gregorian)
      calendar.timeZone = .gmt
      return calendar
    }

    /// 15 Nov 2023 — the budget then runs to 14 Dec.
    static var startDate: Date {
      calendar.date(from: DateComponents(year: 2023, month: 11, day: 15)) ?? .distantPast
    }

    static let expectedUIModel = OnboardingBudgetPeriodUIModel(
      stepLabel: "Step 2 of 2",
      progress: 1.0,
      title: "Choose your budget period",
      subtitle: "Your budget runs for 30 days, starting from the day you pick each month.",
      startDateLabel: "Start date",
      startDateText: "November 15, 2023",
      previewCardLabel: "Your budget period",
      previewRangeText: "Nov 15 – Dec 14",
      previewCaption: "30 days · renews automatically every month",
      primaryButtonTitle: "Create budget",
      creationErrorTitle: "Couldn't create your budget",
      creationErrorMessage: "Something went wrong while saving. Please try again.",
      creationErrorDismissTitle: "OK"
    )
  }

  // MARK: - Private Properties

  private let mapper = OnboardingBudgetPeriodUIMapper()

  // MARK: - Tests

  @Test("The budget period mapper produces the expected onboarding content.")
  func test_Map_ProducesExpectedUIModel() {
    let uiModel = mapper.map(
      startDate: Constants.startDate,
      calendar: Constants.calendar,
      locale: Constants.locale
    )

    #expect(uiModel == Constants.expectedUIModel)
  }
}
