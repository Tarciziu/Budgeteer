//
//  OnboardingBudgetPeriodViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Testing
import Combine
import BTBusinessCore

@testable import BTCustomerExperience

struct OnboardingBudgetPeriodViewModelTests {
  // MARK: - Nested Types

  private enum TestError: Error {
    case failed
  }

  // MARK: - Constants

  private enum Constants {
    /// 2023-11-14 22:13:20 UTC — "the next day" is then 15 Nov.
    static let referenceDate = Date(timeIntervalSince1970: 1_700_000_000)
    static let locale = Locale(identifier: "en_US")

    static var calendar: Calendar {
      var calendar = Calendar(identifier: .gregorian)
      calendar.timeZone = .gmt
      return calendar
    }

    /// The default / earliest selectable start date given `referenceDate`.
    static var nextDay: Date {
      calendar.date(from: DateComponents(year: 2023, month: 11, day: 15)) ?? .distantPast
    }

    /// A later date the user might pick instead.
    static var laterStartDate: Date {
      calendar.date(from: DateComponents(year: 2023, month: 12, day: 1)) ?? .distantPast
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

  // MARK: - Helpers

  private func makeViewModel(
    provider: OnboardingSelectionDataProvider = OnboardingSelectionDataProvider(),
    useCase: MockedCreateInitialPlanUseCase = MockedCreateInitialPlanUseCase()
  ) -> OnboardingBudgetPeriodViewModel {
    OnboardingBudgetPeriodViewModel(
      dataProvider: provider,
      createInitialPlanUseCase: useCase,
      now: Constants.referenceDate,
      calendar: Constants.calendar,
      locale: Constants.locale
    )
  }

  // MARK: - UI Model

  @Test("The budget period step exposes the expected content.")
  func test_UIModel_MatchesExpectedContent() {
    #expect(makeViewModel().uiModel == Constants.expectedUIModel)
  }

  // MARK: - Start date

  @Test("The selected start date defaults to the next day, which is also the minimum.")
  func test_SelectedStartDate_DefaultsToNextDay() {
    let viewModel = makeViewModel()

    #expect(viewModel.selectedStartDate == Constants.nextDay)
    #expect(viewModel.minimumStartDate == Constants.nextDay)
  }

  @Test("Changing the selected start date re-maps the rendered date and preview range.")
  func test_ChangingSelectedStartDate_RemapsPreview() {
    let viewModel = makeViewModel()

    viewModel.selectedStartDate = Constants.laterStartDate

    #expect(viewModel.uiModel.startDateText == "December 1, 2023")
    #expect(viewModel.uiModel.previewRangeText == "Dec 1 – Dec 31")
  }

  // MARK: - Behaviour

  @Test("Tapping back emits `.backRequested`.")
  func test_HandleBackTap_EmitsBackRequested() async {
    let viewModel = makeViewModel()
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

  @Test("Tapping create builds the plan, calls the use case, then emits `.planCreated` with the persisted plan.")
  func test_HandleCreateTap_BuildsPlanAndEmitsPlanCreated() async {
    let useCase = MockedCreateInitialPlanUseCase()
    useCase.stubbedPlan = BudgetPlanDataGenerator.budgetPlanDM(id: "bp-99", name: "Trip")
    let provider = OnboardingSelectionDataProvider(
      accountName: "Trip",
      startingBalance: 1200,
      currency: .ron
    )
    let viewModel = makeViewModel(provider: provider, useCase: useCase)
    viewModel.selectedStartDate = Constants.laterStartDate
    var cancellable: AnyCancellable?
    var receivedPlan: BudgetPlanDM?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        guard case let .planCreated(plan) = event else { return }
        receivedPlan = plan
        continuation.resume()
      }

      viewModel.handleCreateTap()
    }

    cancellable?.cancel()

    #expect(receivedPlan == useCase.stubbedPlan)
    #expect(useCase.receivedCreationDMs.count == 1)
    #expect(useCase.receivedCreationDMs.first?.name == "Trip")
    #expect(useCase.receivedCreationDMs.first?.currency == .ron)
    #expect(useCase.receivedCreationDMs.first?.recurrentBalance == 1200)
    #expect(useCase.receivedCreationDMs.first?.openingDate == Constants.laterStartDate)
    #expect(useCase.receivedCreationDMs.first?.monthlyBudget.periodStartDate == Constants.laterStartDate)
    #expect(viewModel.isCreatingPlan == false)
  }

  @Test("When the use case fails, the step surfaces an error and does not advance.")
  func test_HandleCreateTap_WhenUseCaseThrows_SetsErrorAndDoesNotEmit() async {
    let useCase = MockedCreateInitialPlanUseCase()
    useCase.stubbedError = TestError.failed
    let viewModel = makeViewModel(useCase: useCase)

    var didEmit = false
    let eventCancellable = viewModel.eventsPublisher.sink { _ in didEmit = true }
    var errorCancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      var resumed = false
      errorCancellable = viewModel.$hasCreationError
        .dropFirst()
        .sink { hasError in
          guard hasError, !resumed else { return }
          resumed = true
          continuation.resume()
        }

      viewModel.handleCreateTap()
    }

    #expect(viewModel.hasCreationError)
    #expect(viewModel.isCreatingPlan == false)
    #expect(!didEmit)

    eventCancellable.cancel()
    errorCancellable?.cancel()
  }
}
