//
//  MockedGetBudgetPlansUseCase.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import InstantMock
import BTBusinessCore

/// InstantMock based test double for ``GetBudgetPlansUseCase``.
///
/// Stub the outcome with `stub().call(...)` combined with `andReturn(...)` / `andThrow(...)`.
final class MockedGetBudgetPlansUseCase: Mock, GetBudgetPlansUseCase {
  var stubbedPlans: [BudgetPlanDM] = []
  var stubbedError: Error?

  func getBudgetPlans() async throws -> [BudgetPlanDM] {
    try callThrowing() ?? []
  }
}

/// Error used to stub failing launch use-case calls.
enum AppLaunchTestError: Error {
  case failed
}
