//
//  OnboardingBudgetPeriodViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing
import Combine

@testable import BTCustomerExperience

struct OnboardingBudgetPeriodViewModelTests {
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

  private let viewModel = OnboardingBudgetPeriodViewModel()

  // MARK: - UI Model

  @Test("The budget period step exposes the expected content.")
  func test_UIModel_MatchesExpectedContent() {
    #expect(viewModel.uiModel == Constants.expectedUIModel)
  }

  // MARK: - Behaviour

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

  @Test("Tapping create emits `.createRequested`.")
  func test_HandleCreateTap_EmitsCreateRequested() async {
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .createRequested)
        continuation.resume()
      }

      viewModel.handleCreateTap()
    }

    cancellable?.cancel()
  }
}
