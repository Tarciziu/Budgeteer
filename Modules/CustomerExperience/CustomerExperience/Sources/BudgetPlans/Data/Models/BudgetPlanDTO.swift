//
//  BudgetPlanDTO.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import BTCore

/// Data transfer model describing a stored budget plan.
public struct BudgetPlanDTO: DataSourceModel {
  public let id: String
  public let name: String
  public let openingDate: Date
  public let currency: String
  public let periodStartDay: PeriodDayDTO
  public let recurrentBalance: Decimal
  /// Monthly budgets of the plan. A new period is appended once the previous one's `periodEndDate` is reached.
  public let monthlyBudgets: [MonthlyBudgetDTO]

  /// Creates a new `BudgetPlanDTO`.
  /// - Parameters:
  ///   - id: Unique identifier of the budget plan.
  ///   - name: Name of the budget plan.
  ///   - openingDate: Date at which the budget plan was created.
  ///   - currency: Currency code the budget plan is expressed in.
  ///   - periodStartDay: Start day of the budget plan's period.
  ///   - recurrentBalance: Default value of a budget. (e.g.: salary)
  ///   - monthlyBudgets: List of monthly budgets part of the plan.
  public init(
    id: String,
    name: String,
    openingDate: Date,
    currency: String,
    periodStartDay: PeriodDayDTO,
    recurrentBalance: Decimal,
    monthlyBudgets: [MonthlyBudgetDTO]
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

/// Data transfer model describing a single monthly budget of a plan.
public struct MonthlyBudgetDTO: DataSourceModel {
  public let id: String
  public let startingBalance: Decimal
  public let periodStartDate: Date
  public let periodEndDate: Date

  /// Creates a new `MonthlyBudgetDTO`.
  /// - Parameters:
  ///   - id: Unique identifier of the monthly budget.
  ///   - startingBalance: Balance at the start of the period.
  ///   - periodStartDate: Start date of the period.
  ///   - periodEndDate: End date of the period.
  public init(
    id: String,
    startingBalance: Decimal,
    periodStartDate: Date,
    periodEndDate: Date
  ) {
    self.id = id
    self.startingBalance = startingBalance
    self.periodStartDate = periodStartDate
    self.periodEndDate = periodEndDate
  }
}
