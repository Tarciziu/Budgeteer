//
//  BudgetPlanDataGenerator.swift
//  BusinessCoreTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import BTBusinessCore

/// Factory helpers producing budget plan domain models for the use case tests.
enum BudgetPlanDataGenerator {
  static let referenceDate = Date(timeIntervalSince1970: 1_700_000_000)

  static func monthlyBudget(id: String = "mb-1") -> MonthlyBudgetDM {
    MonthlyBudgetDM(
      id: id,
      startingBalance: 1_000,
      periodStartDate: referenceDate,
      periodEndDate: referenceDate.addingTimeInterval(60 * 60 * 24 * 30)
    )
  }

  static func monthlyBudgetCreation() -> MonthlyBudgetCreationDM {
    MonthlyBudgetCreationDM(
      startingBalance: 1_000,
      currentBalance: 750,
      periodStartDate: referenceDate,
      periodEndDate: referenceDate.addingTimeInterval(60 * 60 * 24 * 30)
    )
  }

  static func budgetPlan(id: String = "bp-1", name: String = "Household") -> BudgetPlanDM {
    BudgetPlanDM(
      id: id,
      name: name,
      openingDate: referenceDate,
      currency: .eur,
      periodStartDay: .day01,
      recurrentBalance: 3_500,
      monthlyBudgets: [monthlyBudget()]
    )
  }

  static func budgetPlanCreation(name: String = "Household") -> BudgetPlanCreationDM {
    BudgetPlanCreationDM(
      name: name,
      openingDate: referenceDate,
      currency: .eur,
      periodStartDay: .day01,
      recurrentBalance: 3_500,
      monthlyBudget: monthlyBudgetCreation()
    )
  }
}
