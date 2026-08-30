//
//  DefaultBudgetPlanRepositoryTests.swift
//  CustomerExperienceTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import Testing
import InstantMock
import BTCore
import BTBusinessCore
@testable import BTCustomerExperience

struct DefaultBudgetPlanRepositoryTests {
  // MARK: - Private Properties

  private let dataSource = MockedDataSource()
  private let repository: DefaultBudgetPlanRepository

  // MARK: - Init

  init() {
    repository = DefaultBudgetPlanRepository(dataSource: dataSource)
  }

  // MARK: - Helpers

  /// Stubs the next `executeRequest` call with the provided response and clears the request recorded during registration.
  private func stubResponse(_ dtos: [BudgetPlanDTO]?) async throws {
    dataSource.stub()
      .call(try await dataSource.executeRequest(request: .init(id: "stub")) as [BudgetPlanDTO]?)
      .andReturn(dtos)
    dataSource.clearRecordedRequests()
  }

  // MARK: - getBudgetPlans

  @Test("Requests the budget plans endpoint and maps the response")
  func test_GetBudgetPlans_RequestsEndpointAndMapsResponse() async throws {
    // Given
    try await stubResponse([
      BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-1"),
      BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-2")
    ])

    // When
    let result = try await repository.getBudgetPlans()

    // Then
    let request = try #require(dataSource.lastExecutedRequest)
    #expect(request.id == BudgetPlanEndpotsID.getBudgetPlans.rawValue)
    #expect(request.headers.isEmpty)
    #expect(request.body == nil)
    #expect(result.map(\.id) == ["bp-1", "bp-2"])
  }

  @Test("Returns an empty list when the data source has no budget plans")
  func test_GetBudgetPlans_ReturnsEmptyListWhenResponseIsNil() async throws {
    // Given
    try await stubResponse(nil)

    // When
    let result = try await repository.getBudgetPlans()

    // Then
    #expect(result.isEmpty)
  }

  // MARK: - getBudgetPlan(id:)

  @Test("Requests a single budget plan by identifier passed as a header")
  func test_GetBudgetPlan_PassesIdentifierAsHeaderAndMapsResponse() async throws {
    // Given
    try await stubResponse([BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-77")])

    // When
    let result = try await repository.getBudgetPlan(id: "bp-77")

    // Then
    let request = try #require(dataSource.lastExecutedRequest)
    #expect(request.id == BudgetPlanEndpotsID.getBudgetPlan.rawValue)
    #expect(request.headers["bpId"] == "bp-77")
    #expect(result.id == "bp-77")
  }

  @Test("Throws when the data source returns no budget plan for the identifier")
  func test_GetBudgetPlan_ThrowsWhenResponseIsEmpty() async throws {
    // Given
    try await stubResponse([])

    // When / Then
    await #expect(throws: DataSourceError.missingData) {
      _ = try await repository.getBudgetPlan(id: "bp-1")
    }
  }

  // MARK: - storeBudgetPlan

  @Test("Sends the mapped creation request DTO to the create endpoint and maps the response")
  func test_StoreBudgetPlan_SendsMappedBodyAndMapsResponse() async throws {
    // Given
    let creationDM = BudgetPlanDataGenerator.budgetPlanCreationDM(currency: .usd)
    try await stubResponse([BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-created")])

    // When
    let result = try await repository.storeBudgetPlan(creationDM)

    // Then
    let request = try #require(dataSource.lastExecutedRequest)
    #expect(request.id == BudgetPlanEndpotsID.createBudgetPlan.rawValue)

    let body = try #require(request.body as? BudgetPlanCreationRequestDTO)
    #expect(body.name == "Household")
    #expect(body.currency == "USD")
    #expect(body.periodStartDay == .day05)
    #expect(body.monthlyBudget.startingBalance == 1_000)

    #expect(result.id == "bp-created")
  }

  @Test("Throws when the create endpoint returns no budget plan")
  func test_StoreBudgetPlan_ThrowsWhenResponseIsEmpty() async throws {
    // Given
    try await stubResponse(nil)

    // When / Then
    await #expect(throws: DataSourceError.missingData) {
      _ = try await repository.storeBudgetPlan(BudgetPlanDataGenerator.budgetPlanCreationDM())
    }
  }

  // MARK: - Error propagation

  @Test("Propagates the error thrown by the data source")
  func test_GetBudgetPlans_PropagatesDataSourceError() async throws {
    // Given
    dataSource.stub()
      .call(try await dataSource.executeRequest(request: .init(id: "stub")) as [BudgetPlanDTO]?)
      .andThrow(DataSourceTestError.stubbed)

    // When / Then
    await #expect(throws: DataSourceTestError.stubbed) {
      _ = try await repository.getBudgetPlans()
    }
  }
}
