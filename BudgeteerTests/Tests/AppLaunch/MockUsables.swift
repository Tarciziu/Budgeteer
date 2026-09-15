//
//  MockUsables.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 08/09/2026.
//

import InstantMock
import BTBusinessCore

/// `MockUsable` conformance so `[BudgetPlanDM]` can flow through InstantMock stubs / expectations.
extension BudgetPlanDM: @retroactive MockUsable {
  public static var anyValue: any InstantMock.MockUsable {
    BudgetPlanDataGenerator.budgetPlanDM()
  }

  public func equal(to value: (any MockUsable)?) -> Bool {
    guard let plan = value as? BudgetPlanDM else { return false }
    return self == plan
  }
}
