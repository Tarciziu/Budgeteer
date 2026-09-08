//
//  MockUsables.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 08/09/2026.
//

import Foundation
import InstantMock
import BTBusinessCore
@testable import BTCustomerExperience

/// `MockUsable` conformances so the transaction domain models can be matched and returned by
/// InstantMock stubs / expectations (see `Arg.any()`, `Arg.verify(_:)`).

extension BudgetPlanDM: @retroactive MockUsable {
  public static var anyValue: any InstantMock.MockUsable {
    BudgetPlanDataGenerator.budgetPlanDM()
  }

  public func equal(to value: (any MockUsable)?) -> Bool {
    guard let other = value as? BudgetPlanDM else { return false }
    return self == other
  }
}

extension TransactionDM: @retroactive MockUsable {
  public static var anyValue: any InstantMock.MockUsable {
    TransactionDataGenerator.transactionDM()
  }

  public func equal(to value: (any MockUsable)?) -> Bool {
    guard let other = value as? TransactionDM else { return false }
    return self == other
  }
}

extension TransactionParametersDM: @retroactive MockUsable {
  public static var anyValue: any InstantMock.MockUsable {
    TransactionDataGenerator.transactionParametersDM()
  }

  public func equal(to value: (any MockUsable)?) -> Bool {
    guard let other = value as? TransactionParametersDM else { return false }
    return self == other
  }
}
