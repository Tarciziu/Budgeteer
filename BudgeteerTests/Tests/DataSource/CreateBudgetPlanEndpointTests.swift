//
//  CreateBudgetPlanEndpointTests.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import Testing
import SwiftData
import BTCore
import BTCustomerExperience

@testable import Budgeteer

struct CreateBudgetPlanEndpointTests {
  // MARK: - Constants

  private enum Constants {
    static let endpointID = BudgetPlanEndpotsID.createBudgetPlan.rawValue
    static let start = Date(timeIntervalSince1970: 1_700_000_000)
    static let end = Date(timeIntervalSince1970: 1_702_591_999)
  }

  // MARK: - Helpers

  private func makeContainer() throws -> ModelContainer {
    try ModelContainer(
      for: BudgetPlanModel.self,
      configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
  }

  private func makeRequestBody() -> BudgetPlanCreationRequestDTO {
    BudgetPlanCreationRequestDTO(
      name: "Trip",
      openingDate: Constants.start,
      currency: "RON",
      periodStartDay: .day08,
      recurrentBalance: 3200,
      monthlyBudget: MonthlyBudgetCreationRequestDTO(
        startingBalance: 3200,
        periodStartDate: Constants.start,
        periodEndDate: Constants.end
      )
    )
  }

  // MARK: - Tests

  @Test("Persists the budget plan and returns a DTO mirroring the request")
  func test_ExecuteRequest_PersistsPlanAndReturnsDTO() async throws {
    let container = try makeContainer()
    let endpoint = CreateBudgetPlanEndpoint(id: Constants.endpointID, modelContainer: container)
    let request = Request(id: Constants.endpointID, body: makeRequestBody())

    let result: [BudgetPlanDTO]? = try await endpoint.executeRequest(requestModel: request)

    let dto = try #require(result?.first)
    #expect(dto.name == "Trip")
    #expect(dto.currency == "RON")
    #expect(dto.periodStartDay == .day08)
    #expect(dto.recurrentBalance == 3200)
    #expect(dto.openingDate == Constants.start)
    #expect(dto.monthlyBudgets.count == 1)
    #expect(dto.monthlyBudgets.first?.startingBalance == 3200)
    #expect(!dto.id.isEmpty)

    let stored = try ModelContext(container).fetch(FetchDescriptor<BudgetPlanModel>())
    #expect(stored.count == 1)
    #expect(stored.first?.identifier == dto.id)
    #expect(stored.first?.name == "Trip")
    #expect(stored.first?.currencyCode == "RON")
    #expect(stored.first?.periodStartDayRaw == "DAY_08")
    #expect(stored.first?.monthlyStartingBalance == 3200)
  }

  @Test("Throws when the request body is not a budget plan creation DTO")
  func test_ExecuteRequest_WithInvalidBody_Throws() async throws {
    let endpoint = CreateBudgetPlanEndpoint(id: Constants.endpointID, modelContainer: try makeContainer())

    await #expect(throws: DataSourceError.invalidDataSource) {
      _ = try await endpoint.executeRequest(requestModel: Request(id: Constants.endpointID)) as [BudgetPlanDTO]?
    }
  }
}
