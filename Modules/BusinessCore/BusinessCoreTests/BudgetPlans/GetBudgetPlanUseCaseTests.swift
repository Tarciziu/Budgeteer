//
//  GetBudgetPlanUseCaseTests.swift
//  BusinessCoreTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Testing
import InstantMock
import BTBusinessCore

struct GetBudgetPlanUseCaseTests {
  // MARK: - Private Properties

  private let repository = MockedBudgetPlanRepository()
  private let useCase: DefaultGetBudgetPlanUseCase

  // MARK: - Init

  init() {
    useCase = DefaultGetBudgetPlanUseCase(repository: repository)
  }

  // MARK: - Tests

  @Test("Requests the plan with the provided identifier and returns it")
  func test_GetBudgetPlan_ForwardsIdentifierAndReturnsResult() async throws {
    // Given
    let expected = BudgetPlanDataGenerator.budgetPlan(id: "bp-42")
    repository.stub().call(try await repository.getBudgetPlan(id: "bp-42")).andReturn(expected)
    repository.clearRecordedInteractions()

    // When
    let result = try await useCase.getBudgetPlan(id: "bp-42")

    // Then
    #expect(result == expected)
    #expect(repository.requestedIDs == ["bp-42"])
  }

  @Test("Propagates the error thrown by the repository")
  func test_GetBudgetPlan_PropagatesRepositoryError() async throws {
    // Given
    repository.stub().call(try await repository.getBudgetPlan(id: "bp-1")).andThrow(BudgetPlanTestError.stubbed)

    // When / Then
    await #expect(throws: BudgetPlanTestError.stubbed) {
      _ = try await useCase.getBudgetPlan(id: "bp-1")
    }
  }
}
