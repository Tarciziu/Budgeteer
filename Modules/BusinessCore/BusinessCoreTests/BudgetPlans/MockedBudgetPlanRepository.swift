//
//  MockedBudgetPlanRepository.swift
//  BusinessCoreTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import InstantMock
import BTBusinessCore

/// InstantMock based test double for ``BudgetPlanRepository``.
///
/// Configure the outcome of each method with `stub().call(...)` combined with `andReturn(...)` / `andThrow(...)`.
/// The arguments received on the real calls are recorded in ``requestedIDs`` / ``storedCreationDMs``; call
/// ``clearRecordedInteractions()`` right after the stub is registered to drop the values captured during registration.
final class MockedBudgetPlanRepository: Mock, BudgetPlanRepository {
  // MARK: - Recorded interactions

  private(set) var requestedIDs: [String] = []
  private(set) var storedCreationDMs: [BudgetPlanCreationDM] = []

  // MARK: - BudgetPlanRepository

  func getBudgetPlans() async throws -> [BudgetPlanDM] {
    try callThrowing() ?? []
  }

  func getBudgetPlan(id: String) async throws -> BudgetPlanDM {
    requestedIDs.append(id)
    return try callThrowing() ?? BudgetPlanDataGenerator.budgetPlan()
  }

  @discardableResult
  func storeBudgetPlan(_ creationDM: BudgetPlanCreationDM) async throws -> BudgetPlanDM {
    storedCreationDMs.append(creationDM)
    return try callThrowing() ?? BudgetPlanDataGenerator.budgetPlan()
  }

  // MARK: - Helpers

  func clearRecordedInteractions() {
    requestedIDs.removeAll()
    storedCreationDMs.removeAll()
  }
}

/// Error used to stub failing repository calls.
enum BudgetPlanTestError: Error {
  case stubbed
}
