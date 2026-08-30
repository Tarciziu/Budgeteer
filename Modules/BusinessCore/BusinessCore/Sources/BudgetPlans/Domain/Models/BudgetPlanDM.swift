//
//  BudgetPlanDM.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation

/// Domain representation of a budget plan.
public struct BudgetPlanDM: Identifiable, Equatable {
  /// Unique identifier of the budget plan.
  public let id: String
  /// Name of the budget plan.
  public let name: String
  /// Date representing the moment of the plan's creation.
  public let openingDate: Date
  /// Currency of the Budget Plan.
  public let currency: CurrencyDM
  /// Start day of the budget plan's period.
  /// Example: day08 - representing the 8th of the month.
  public let periodStartDay: PeriodDayDM
  /// Default value of a budget. (e.g.: salary)
  public let recurrentBalance: Decimal
  /// List of budgets part of a Budget Plan.
  public let monthlyBudgets: [MonthlyBudgetDM]

  /// Initializes a new ``BudgetPlanDM``.
  /// - Parameters:
  ///   - id: Unique identifier of the budget plan.
  ///   - name: String representing the name of the budget plan.
  ///   - openingDate: Date representing the moment of the plan's creation.
  ///   - currency: Currency of the Budget Plan.
  ///   - periodStartDay: Start day of the budget plan's period.
  ///   - recurrentBalance: Default value of a budget. (e.g.: salary)
  ///   - monthlyBudgets: List of budgets part of a Budget Plan.
  public init(
    id: String,
    name: String,
    openingDate: Date,
    currency: CurrencyDM,
    periodStartDay: PeriodDayDM,
    recurrentBalance: Decimal,
    monthlyBudgets: [MonthlyBudgetDM]
  ) {
    self.id = id
    self.name = name
    self.openingDate = openingDate
    self.currency = currency
    self.periodStartDay = periodStartDay
    self.recurrentBalance = recurrentBalance
    self.monthlyBudgets = monthlyBudgets
  }
}
