//
//  BudgetPlanDataGenerator.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 08/09/2026.
//

import Foundation
import BTBusinessCore

/// Factory helpers producing budget plan domain models for the app-launch tests.
enum BudgetPlanDataGenerator {
  static let referenceDate = Date(timeIntervalSince1970: 1_700_000_000)

  static func budgetPlanDM(
    id: String = "bp-1",
    name: String = "Household"
  ) -> BudgetPlanDM {
    BudgetPlanDM(
      id: id,
      name: name,
      openingDate: referenceDate,
      currency: .ron,
      periodStartDay: .day01,
      recurrentBalance: 3_000,
      monthlyBudgets: [
        MonthlyBudgetDM(
          id: "mb-1",
          startingBalance: 3_000,
          periodStartDate: referenceDate,
          periodEndDate: Date(timeIntervalSince1970: 1_702_591_999)
        )
      ]
    )
  }
}
