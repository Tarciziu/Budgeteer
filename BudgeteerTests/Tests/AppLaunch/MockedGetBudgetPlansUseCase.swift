//
//  MockedGetBudgetPlansUseCase.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTBusinessCore

/// Test double for ``GetBudgetPlansUseCase``.
///
/// Returns ``stubbedPlans`` unless ``stubbedError`` is set, in which case the call throws.
final class MockedGetBudgetPlansUseCase: GetBudgetPlansUseCase {
  var stubbedPlans: [BudgetPlanDM] = []
  var stubbedError: Error?

  func getBudgetPlans() async throws -> [BudgetPlanDM] {
    if let stubbedError {
      throw stubbedError
    }
    return stubbedPlans
  }
}

enum AppLaunchTestError: Error {
  case failed
}

/// Minimal ``BudgetPlanDM`` fixture for the launch tests.
func makeBudgetPlanDM(id: String = "bp-1") -> BudgetPlanDM {
  BudgetPlanDM(
    id: id,
    name: "Household",
    openingDate: Date(timeIntervalSince1970: 1_700_000_000),
    currency: .ron,
    periodStartDay: .day01,
    recurrentBalance: 3_000,
    monthlyBudgets: [
      MonthlyBudgetDM(
        id: "mb-1",
        startingBalance: 3_000,
        periodStartDate: Date(timeIntervalSince1970: 1_700_000_000),
        periodEndDate: Date(timeIntervalSince1970: 1_702_591_999)
      )
    ]
  )
}
