//
//  TransactionDataGenerator.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import Foundation
@testable import BTCustomerExperience

/// Factory helpers producing transaction domain models for the presentation-layer tests.
enum TransactionDataGenerator {
  static let transactionDate = Date(timeIntervalSince1970: 1_700_000_000)

  static func transactionDM(
    id: String = "tx-1",
    title: String = "Coffee",
    description: String? = "Morning coffee",
    amount: Decimal = 4.5,
    category: TransactionCategoryDM = .groceries,
    budgetPlanId: String = "bp-1"
  ) -> TransactionDM {
    TransactionDM(
      id: id,
      title: title,
      description: description,
      amount: amount,
      category: category,
      transactionDate: transactionDate,
      budgetPlanId: budgetPlanId
    )
  }

  static func transactionParametersDM(
    title: String = "Coffee",
    description: String? = "Morning coffee",
    amount: Decimal = 4.5,
    category: TransactionCategoryDM = .groceries,
    budgetPlanId: String = "bp-1"
  ) -> TransactionParametersDM {
    TransactionParametersDM(
      title: title,
      description: description,
      amount: amount,
      category: category,
      transactionDate: transactionDate,
      budgetPlanId: budgetPlanId
    )
  }
}
