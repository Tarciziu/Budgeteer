//
//  CreateBudgetPlanUseCaseTests.swift
//  BusinessCoreTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Testing
import InstantMock
import BTBusinessCore

struct CreateBudgetPlanUseCaseTests {
  // MARK: - Private Properties

  private let repository = MockedBudgetPlanRepository()
  private let useCase: DefaultCreateBudgetPlanUseCase

  // MARK: - Init

  init() {
    useCase = DefaultCreateBudgetPlanUseCase(repository: repository)
  }

  // MARK: - Tests

  @Test("Forwards the creation model to the repository unchanged")
  func test_CreateBudgetPlan_ForwardsCreationModelToRepository() async throws {
    // Given
    let creationDM = BudgetPlanDataGenerator.budgetPlanCreation(name: "Trip")
    repository.stub()
      .call(
        try await repository.storeBudgetPlan(creationDM)
      )
      .andReturn(BudgetPlanDataGenerator.budgetPlan())
    repository.clearRecordedInteractions()

    // When
    try await useCase.createBudgetPlan(creationDM)

    // Then
    #expect(repository.storedCreationDMs == [creationDM])
  }

  @Test("Propagates the error thrown by the repository")
  func test_CreateBudgetPlan_PropagatesRepositoryError() async throws {
    // Given
    repository.stub()
      .call(
        try await repository.storeBudgetPlan(BudgetPlanDataGenerator.budgetPlanCreation())
      )
      .andThrow(BudgetPlanTestError.stubbed)

    // When / Then
    await #expect(throws: BudgetPlanTestError.stubbed) {
      try await useCase.createBudgetPlan(BudgetPlanDataGenerator.budgetPlanCreation())
    }
  }
}
