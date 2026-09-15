//
//  OnboardingAccountViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing
import Combine
import BTBusinessCore

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
      balanceErrorText: "Enter an amount greater than zero.",
      primaryButtonTitle: "Continue",
      defaultName: "Cont principal",
      defaultBalance: "",
      defaultCurrencyCode: "RON"
    )
  }

  // MARK: - Private Properties

  private let dataProvider = OnboardingSelectionDataProvider()
  private let viewModel: OnboardingAccountViewModel

  // MARK: - Init

  init() {
    viewModel = OnboardingAccountViewModel(dataProvider: dataProvider)
  }

  // MARK: - UI Model

  @Test("The account view model exposes the expected content and seeds the form (balance starts empty).")
  func test_UIModel_MatchesExpectedContentAndSeedsForm() {
    #expect(viewModel.uiModel == Constants.expectedUIModel)
    #expect(viewModel.name == Constants.expectedUIModel.defaultName)
    #expect(viewModel.startingBalance.isEmpty)
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

  @Test("Tapping continue writes the edited values onto the data provider and emits `.continueRequested`.")
  func test_HandleContinueTap_WritesSelectionsToProviderAndEmitsContinue() async {
    viewModel.name = "Familie"
    viewModel.startingBalance = "5000"
    viewModel.selectCurrency(at: 1)
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .continueRequested)
        continuation.resume()
      }

      viewModel.handleContinueTap()
    }

    cancellable?.cancel()

    #expect(dataProvider.getAccountName() == "Familie")
    #expect(dataProvider.getStartingBalance() == 5000)
    #expect(dataProvider.getCurrency() == .eur)
  }

  @Test("Tapping continue without ever touching the balance flags an error and does not advance.")
  func test_HandleContinueTap_WithUntouchedBalance_FlagsErrorAndDoesNotEmit() {
    var didEmit = false
    let cancellable = viewModel.eventsPublisher.sink { _ in didEmit = true }

    viewModel.handleContinueTap()

    #expect(viewModel.startingBalance.isEmpty)
    #expect(viewModel.hasBalanceError)
    #expect(!didEmit)
    #expect(dataProvider.getStartingBalance() == 3_000)

    cancellable.cancel()
  }

  @Test("Tapping continue with a non-positive balance flags an error, does not advance and leaves the provider untouched.")
  func test_HandleContinueTap_WithNonPositiveBalance_FlagsErrorAndDoesNotEmit() {
    viewModel.startingBalance = "0"
    var didEmit = false
    let cancellable = viewModel.eventsPublisher.sink { _ in didEmit = true }

    viewModel.handleContinueTap()

    #expect(viewModel.hasBalanceError)
    #expect(!didEmit)
    #expect(dataProvider.getAccountName() == "Cont principal")

    viewModel.startingBalance = "100"
    #expect(!viewModel.hasBalanceError)

    cancellable.cancel()
  }
}
