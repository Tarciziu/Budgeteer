//
//  OnboardingAccountUIMapperTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing

@testable import BTCustomerExperience

struct OnboardingAccountUIMapperTests {
  // MARK: - Constants

  private enum Constants {
    static let expectedUIModel = OnboardingAccountUIModel(
      stepLabel: "Step 1 of 2",
      progress: 0.5,
      title: "Create your first account",
      subtitle: "Choose a name and the currency you want to manage your budget in.",
      nameFieldLabel: "Account name",
      nameFieldPlaceholder: "Main account",
      balanceFieldLabel: "Starting balance",
      balanceFieldPlaceholder: "0",
      currencyGroupLabel: "Currency",
      currencyCodes: ["RON", "EUR", "USD", "GBP"],
      primaryButtonTitle: "Continue",
      defaultName: "Cont principal",
      defaultBalance: "3.000",
      defaultCurrencyCode: "RON"
    )
  }

  // MARK: - Private Properties

  private let mapper = OnboardingAccountUIMapper()

  // MARK: - Tests

  @Test("The account mapper produces the expected onboarding form content.")
  func test_Map_ProducesExpectedUIModel() {
    #expect(mapper.map() == Constants.expectedUIModel)
  }
}
