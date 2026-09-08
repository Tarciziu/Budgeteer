//
//  AppLaunchFailureViewModelTests.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Testing
import Combine
import BTBusinessCore

@testable import Budgeteer

struct AppLaunchFailureViewModelTests {
  // MARK: - Constants

  private enum Constants {
    static let expectedUIModel = AppLaunchFailureUIModel(
      title: "Something went wrong",
      message: "We couldn't load your data. Please try again.",
      retryButtonTitle: "Try again"
    )
  }

  // MARK: - UI Model

  @Test("The failure screen exposes the expected content.")
  func test_UIModel_MatchesExpectedContent() {
    let viewModel = AppLaunchFailureViewModel(getBudgetPlansUseCase: MockedGetBudgetPlansUseCase())

    #expect(viewModel.uiModel == Constants.expectedUIModel)
  }

  // MARK: - Retry

  @Test("Retrying with no stored plans emits `.retrySucceeded(.newCustomerSetup)`.")
  func test_HandleRetryTap_WithNoStoredPlans_EmitsRetrySucceededOnboarding() async {
    let useCase = MockedGetBudgetPlansUseCase()
    useCase.stubbedPlans = []
    let viewModel = AppLaunchFailureViewModel(getBudgetPlansUseCase: useCase)
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .retrySucceeded(.newCustomerSetup))
        continuation.resume()
      }

      viewModel.handleRetryTap()
    }

    cancellable?.cancel()
    #expect(viewModel.isRetrying == false)
  }

  @Test("Retrying with stored plans emits `.retrySucceeded(.mainApp)`.")
  func test_HandleRetryTap_WithStoredPlans_EmitsRetrySucceededMainApp() async {
    let useCase = MockedGetBudgetPlansUseCase()
    useCase.stubbedPlans = [makeBudgetPlanDM()]
    let viewModel = AppLaunchFailureViewModel(getBudgetPlansUseCase: useCase)
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .retrySucceeded(.mainApp))
        continuation.resume()
      }

      viewModel.handleRetryTap()
    }

    cancellable?.cancel()
    #expect(viewModel.isRetrying == false)
  }

  @Test("A failing retry emits nothing and clears the loading state.")
  func test_HandleRetryTap_WhenFetchThrows_EmitsNothingAndResetsLoading() async {
    let useCase = MockedGetBudgetPlansUseCase()
    useCase.stubbedError = AppLaunchTestError.failed
    let viewModel = AppLaunchFailureViewModel(getBudgetPlansUseCase: useCase)

    var didEmit = false
    let eventCancellable = viewModel.eventsPublisher.sink { _ in didEmit = true }
    var loadingCancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      var resumed = false
      loadingCancellable = viewModel.$isRetrying
        .dropFirst()
        .sink { isRetrying in
          guard !isRetrying, !resumed else { return }
          resumed = true
          continuation.resume()
        }

      viewModel.handleRetryTap()
    }

    #expect(viewModel.isRetrying == false)
    #expect(!didEmit)

    eventCancellable.cancel()
    loadingCancellable?.cancel()
  }
}
