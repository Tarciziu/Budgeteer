//
//  MockedGetBudgetPlansUseCase.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import InstantMock
import BTBusinessCore

/// InstantMock based test double for ``GetBudgetPlansUseCase``.
///
/// Configure it with `stub().call(...)` / `expect().call(...)` combined with `andReturn(...)` /
/// `andThrow(...)`.
final class MockedGetBudgetPlansUseCase: Mock, GetBudgetPlansUseCase {
  init() {
    super.init(SwiftTestingMock.factory)
  }

  func getBudgetPlans() async throws -> [BudgetPlanDM] {
    try callThrowing() ?? []
  }
}
