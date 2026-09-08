//
//  AppLaunchViewModelTests.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Testing
import InstantMock
import BTBusinessCore

@testable import Budgeteer

@MainActor
struct AppLaunchViewModelTests {
  // MARK: - Helpers

  private func makeViewModel(
    useCase: MockedGetBudgetPlansUseCase = MockedGetBudgetPlansUseCase()
  ) -> AppLaunchViewModel {
    AppLaunchViewModel(
      notificationsHandler: LocalNotificationsHandler(),
      getBudgetPlansUseCase: useCase
    )
  }

  // MARK: - resolveInitialPhase()

  @Test("With no stored budget plans the app enters the onboarding phase.")
  func test_ResolveInitialPhase_WithNoStoredPlans_EntersOnboarding() async throws {
    // Given
    let useCase = MockedGetBudgetPlansUseCase()
    useCase.stub().call(try await useCase.getBudgetPlans()).andReturn([])
    let viewModel = makeViewModel(useCase: useCase)

    // When
    await viewModel.resolveInitialPhase()

    // Then
    #expect(viewModel.appPhase == .newCustomerSetup)
  }

  @Test("With at least one stored budget plan the app enters the main phase.")
  func test_ResolveInitialPhase_WithStoredPlans_EntersMainApp() async throws {
    // Given
    let useCase = MockedGetBudgetPlansUseCase()
    useCase.stub().call(try await useCase.getBudgetPlans()).andReturn([BudgetPlanDataGenerator.budgetPlanDM()])
    let viewModel = makeViewModel(useCase: useCase)

    // When
    await viewModel.resolveInitialPhase()

    // Then
    #expect(viewModel.appPhase == .mainApp)
  }

  @Test("When the budget plans read fails the app enters the initialisation-failure phase.")
  func test_ResolveInitialPhase_WhenFetchThrows_EntersInitialisationFailure() async throws {
    // Given
    let useCase = MockedGetBudgetPlansUseCase()
    useCase.stub().call(try await useCase.getBudgetPlans()).andThrow(AppLaunchTestError.failed)
    let viewModel = makeViewModel(useCase: useCase)

    // When
    await viewModel.resolveInitialPhase()

    // Then
    #expect(viewModel.appPhase == .initialisationFailure)
  }

  // MARK: - completeOnboarding()

  @Test("Completing onboarding transitions to the main phase.")
  func test_CompleteOnboarding_EntersMainApp() {
    // Given
    let viewModel = makeViewModel()

    // When
    viewModel.completeOnboarding()

    // Then
    #expect(viewModel.appPhase == .mainApp)
  }
}
