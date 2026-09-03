//
//  OnboardingSuccessViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Testing
import Combine

@testable import BTCustomerExperience

struct OnboardingSuccessViewModelTests {
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

  // MARK: - UI Model

  @Test("The success summary echoes the values collected during the flow.")
  func test_UIModel_ReflectsProvidedSelections() {
    let viewModel = OnboardingSuccessViewModel(selections: Constants.inputSelections)

    #expect(viewModel.uiModel == Constants.expectedUIModel)
  }

  // MARK: - Behaviour

  @Test("Tapping the primary button emits `.goToHomeRequested`.")
  func test_HandleGoToHomeTap_EmitsGoToHomeRequested() async {
    let viewModel = OnboardingSuccessViewModel()
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
