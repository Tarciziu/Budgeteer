//
//  OnboardingAccountViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing
import Combine

@testable import BTCustomerExperience

struct OnboardingAccountViewModelTests {
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

  private let viewModel = OnboardingAccountViewModel()

  // MARK: - UI Model

  @Test("The account view model exposes the expected content and is pre-filled with the dummy defaults.")
  func test_UIModel_MatchesExpectedContentAndSeedsForm() {
    #expect(viewModel.uiModel == Constants.expectedUIModel)
    #expect(viewModel.name == Constants.expectedUIModel.defaultName)
    #expect(viewModel.startingBalance == Constants.expectedUIModel.defaultBalance)
    #expect(
      viewModel.uiModel.currencyCodes[viewModel.selectedCurrencyIndex]
        == Constants.expectedUIModel.defaultCurrencyCode
    )
  }

  // MARK: - Behaviour

  @Test("Selecting a currency updates the selected index.")
  func test_SelectCurrency_UpdatesSelection() {
    viewModel.selectCurrency(at: 1)

    #expect(viewModel.selectedCurrencyIndex == 1)
  }

  @Test("Selecting an out-of-range currency index is ignored.")
  func test_SelectCurrency_OutOfRange_IsIgnored() {
    let original = viewModel.selectedCurrencyIndex

    viewModel.selectCurrency(at: 99)

    #expect(viewModel.selectedCurrencyIndex == original)
  }

  @Test("Tapping continue emits `.continueRequested` carrying the edited form values.")
  func test_HandleContinueTap_EmitsDraftWithEditedValues() async {
    viewModel.name = "Familie"
    viewModel.startingBalance = "5.000"
    viewModel.selectCurrency(at: 1)
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .continueRequested(
          .init(name: "Familie", startingBalance: "5.000", currencyCode: "EUR")
        ))
        continuation.resume()
      }

      viewModel.handleContinueTap()
    }

    cancellable?.cancel()
  }

  @Test("Tapping back emits `.backRequested`.")
  func test_HandleBackTap_EmitsBackRequested() async {
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .backRequested)
        continuation.resume()
      }

      viewModel.handleBackTap()
    }

    cancellable?.cancel()
  }
}
