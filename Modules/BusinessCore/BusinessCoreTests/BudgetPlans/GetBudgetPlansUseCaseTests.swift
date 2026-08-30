//
//  GetBudgetPlansUseCaseTests.swift
//  BusinessCoreTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Testing
import InstantMock
import BTBusinessCore

struct GetBudgetPlansUseCaseTests {
  // MARK: - Private Properties

  private let repository = MockedBudgetPlanRepository()
  private let useCase: DefaultGetBudgetPlansUseCase

  // MARK: - Init

  init() {
    useCase = DefaultGetBudgetPlansUseCase(repository: repository)
  }

  // MARK: - Tests

  @Test("Returns the budget plans provided by the repository")
  func test_GetBudgetPlans_ReturnsRepositoryResult() async throws {
    // Given
    let expected = [
      BudgetPlanDataGenerator.budgetPlan(id: "bp-1", name: "Household"),
      BudgetPlanDataGenerator.budgetPlan(id: "bp-2", name: "Trip")
    ]
    repository.stub().call(try await repository.getBudgetPlans()).andReturn(expected)

    // When
    let result = try await useCase.getBudgetPlans()

    // Then
    #expect(result == expected)
  }

  @Test("Propagates the error thrown by the repository")
  func test_GetBudgetPlans_PropagatesRepositoryError() async throws {
    // Given
    repository.stub().call(try await repository.getBudgetPlans()).andThrow(BudgetPlanTestError.stubbed)

    // When / Then
    await #expect(throws: BudgetPlanTestError.stubbed) {
      _ = try await useCase.getBudgetPlans()
    }
  }
}
