//
//  BudgetPlanDataGenerator.swift
//  CustomerExperienceTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import BTBusinessCore
@testable import BTCustomerExperience

/// Factory helpers producing budget plan data-layer models for the mapper and repository tests.
enum BudgetPlanDataGenerator {
  static let openingDate = Date(timeIntervalSince1970: 1_700_000_000)
  static let periodStartDate = Date(timeIntervalSince1970: 1_701_000_000)
  static let periodEndDate = Date(timeIntervalSince1970: 1_703_592_000)

  static func monthlyBudgetDTO(id: String = "mb-1") -> MonthlyBudgetDTO {
    MonthlyBudgetDTO(
      id: id,
      startingBalance: 1_000,
      periodStartDate: periodStartDate,
      periodEndDate: periodEndDate
    )
  }

  static func budgetPlanDTO(
    id: String = "bp-1",
    name: String = "Household",
    currency: String = "USD",
    periodStartDay: PeriodDayDTO = .day05,
    monthlyBudgets: [MonthlyBudgetDTO] = [monthlyBudgetDTO()]
  ) -> BudgetPlanDTO {
    BudgetPlanDTO(
      id: id,
      name: name,
      openingDate: openingDate,
      currency: currency,
      periodStartDay: periodStartDay,
      recurrentBalance: 4_200,
      monthlyBudgets: monthlyBudgets
    )
  }

  static func budgetPlanCreationDM(
    currency: CurrencyDM = .usd,
    periodStartDay: PeriodDayDM = .day05
  ) -> BudgetPlanCreationDM {
    BudgetPlanCreationDM(
      name: "Household",
      openingDate: openingDate,
      currency: currency,
      periodStartDay: periodStartDay,
      recurrentBalance: 4_200,
      monthlyBudget: MonthlyBudgetCreationDM(
        startingBalance: 1_000,
        currentBalance: 640,
        periodStartDate: periodStartDate,
        periodEndDate: periodEndDate
      )
    )
  }
}
