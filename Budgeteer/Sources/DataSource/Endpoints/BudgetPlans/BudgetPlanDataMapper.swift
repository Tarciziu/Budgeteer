//
//  BudgetPlanDataMapper.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTCustomerExperience

/// Maps the SwiftData ``BudgetPlanModel`` to the ``BudgetPlanDTO`` the repository expects.
struct BudgetPlanDataMapper {
  // MARK: - Internal Methods

  func map(_ plan: BudgetPlanModel) -> BudgetPlanDTO {
    BudgetPlanDTO(
      id: plan.identifier,
      name: plan.name,
      openingDate: plan.openingDate,
      currency: plan.currencyCode,
      periodStartDay: PeriodDayDTO(rawValue: plan.periodStartDayRaw) ?? .lastDayOfMonth,
      recurrentBalance: plan.recurrentBalance,
      monthlyBudgets: [
        MonthlyBudgetDTO(
          id: plan.monthlyIdentifier,
          startingBalance: plan.monthlyStartingBalance,
          periodStartDate: plan.monthlyPeriodStartDate,
          periodEndDate: plan.monthlyPeriodEndDate
        )
      ]
    )
  }
}
