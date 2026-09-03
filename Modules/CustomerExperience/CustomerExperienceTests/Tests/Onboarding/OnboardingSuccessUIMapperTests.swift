//
//  OnboardingSuccessUIMapperTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Testing

@testable import BTCustomerExperience

struct OnboardingSuccessUIMapperTests {
  // MARK: - Constants

  private enum Constants {
    static let inputSelections = OnboardingSelections(
      accountName: "Familie",
      startingBalance: "5.000",
      currencyCode: "EUR",
      periodRangeText: "1 aug – 31 aug (30 zile)"
    )

    static let expectedUIModel = OnboardingSuccessUIModel(
      title: "You're all set!",
      subtitle: "Your account is ready to use. You can change the currency or budget period anytime from settings.",
      rows: [
        OnboardingSuccessUIModel.Row(label: "Account", value: "Familie", isHighlighted: false),
        OnboardingSuccessUIModel.Row(label: "Starting balance", value: "5.000", isHighlighted: false),
        OnboardingSuccessUIModel.Row(label: "Currency", value: "EUR", isHighlighted: false),
        OnboardingSuccessUIModel.Row(
          label: "Current period",
          value: "1 aug – 31 aug (30 zile)",
          isHighlighted: true
        )
      ],
      primaryButtonTitle: "Go to Home"
    )
  }

  // MARK: - Private Properties

  private let mapper = OnboardingSuccessUIMapper()

  // MARK: - Tests

  @Test("The success mapper builds the summary rows from the provided selections.")
  func test_Map_ProducesExpectedUIModel() {
    #expect(mapper.map(selections: Constants.inputSelections) == Constants.expectedUIModel)
  }
}
