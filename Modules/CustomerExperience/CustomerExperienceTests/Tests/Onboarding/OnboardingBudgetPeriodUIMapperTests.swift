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
    static let expectedUIModel = OnboardingBudgetPeriodUIModel(
      stepLabel: "Step 2 of 2",
      progress: 1.0,
      title: "Choose your budget period",
      subtitle: "Your budget runs for 30 days, starting from the day you pick each month.",
      startDateLabel: "Start date",
      startDateText: "5 iulie 2026",
      previewCardLabel: "Your budget period",
      previewRangeText: "5 iulie – 4 august",
      previewCaption: "30 days · renews automatically every month",
      primaryButtonTitle: "Create budget"
    )
  }

  // MARK: - Private Properties

  private let mapper = OnboardingBudgetPeriodUIMapper()

  // MARK: - Tests

  @Test("The budget period mapper produces the expected onboarding content.")
  func test_Map_ProducesExpectedUIModel() {
    #expect(mapper.map() == Constants.expectedUIModel)
  }
}
