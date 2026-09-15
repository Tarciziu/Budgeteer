//
//  CreateInitialPlanUseCaseTests.swift
//  BusinessCoreTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Testing
import InstantMock
import BTBusinessCore

struct CreateInitialPlanUseCaseTests {
  // MARK: - Private Properties

  private let repository = MockedBudgetPlanRepository()
  private let useCase: DefaultCreateInitialPlanUseCase

  // MARK: - Init

  init() {
    useCase = DefaultCreateInitialPlanUseCase(repository: repository)
  }

  // MARK: - Tests

  @Test("Forwards the creation model to the repository unchanged")
  func test_CreateInitialPlan_ForwardsCreationModelToRepository() async throws {
    // Given
    let creationDM = BudgetPlanDataGenerator.budgetPlanCreation(name: "First plan")
    repository.stub()
      .call(
        try await repository.storeBudgetPlan(creationDM)
      )
      .andReturn(BudgetPlanDataGenerator.budgetPlan())
    repository.clearRecordedInteractions()

    // When
    try await useCase.createInitialPlan(creationDM)

    // Then
    #expect(repository.storedCreationDMs == [creationDM])
  }

  @Test("Returns the persisted plan produced by the repository")
  func test_CreateInitialPlan_ReturnsPersistedPlan() async throws {
    // Given
    let creationDM = BudgetPlanDataGenerator.budgetPlanCreation(name: "First plan")
    let persisted = BudgetPlanDataGenerator.budgetPlan(id: "bp-42", name: "First plan")
    repository.stub()
      .call(
        try await repository.storeBudgetPlan(creationDM)
      )
      .andReturn(persisted)
    repository.clearRecordedInteractions()

    // When
    let result = try await useCase.createInitialPlan(creationDM)

    // Then
    #expect(result == persisted)
  }

  @Test("Propagates the error thrown by the repository")
  func test_CreateInitialPlan_PropagatesRepositoryError() async throws {
    // Given
    repository.stub()
      .call(
        try await repository.storeBudgetPlan(BudgetPlanDataGenerator.budgetPlanCreation())
      )
      .andThrow(BudgetPlanTestError.stubbed)

    // When / Then
    await #expect(throws: BudgetPlanTestError.stubbed) {
      try await useCase.createInitialPlan(BudgetPlanDataGenerator.budgetPlanCreation())
    }
  }
}
