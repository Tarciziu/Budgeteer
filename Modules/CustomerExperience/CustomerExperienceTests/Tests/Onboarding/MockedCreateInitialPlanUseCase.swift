//
//  MockedCreateInitialPlanUseCase.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTBusinessCore

/// Test double for ``CreateInitialPlanUseCase``.
///
/// Records every ``BudgetPlanCreationDM`` it receives and returns ``stubbedPlan``; set
/// ``stubbedError`` to make the next call throw instead.
final class MockedCreateInitialPlanUseCase: CreateInitialPlanUseCase {
  private(set) var receivedCreationDMs: [BudgetPlanCreationDM] = []
  var stubbedError: Error?
  var stubbedPlan: BudgetPlanDM = BudgetPlanDataGenerator.budgetPlanDM()

  @discardableResult
  func createInitialPlan(_ creationDM: BudgetPlanCreationDM) async throws -> BudgetPlanDM {
    receivedCreationDMs.append(creationDM)
    if let stubbedError {
      throw stubbedError
    }
    return stubbedPlan
  }
}
