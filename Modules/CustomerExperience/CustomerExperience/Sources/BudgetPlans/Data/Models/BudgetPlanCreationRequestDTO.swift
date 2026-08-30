//
//  BudgetPlanCreationRequestDTO.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import BTCore

/// Request body used to create a new budget plan.
public struct BudgetPlanCreationRequestDTO: DataSourceModel {
  public let name: String
  public let openingDate: Date
  public let currency: String
  public let periodStartDay: PeriodDayDTO
  public let recurrentBalance: Decimal
  public let monthlyBudget: MonthlyBudgetCreationRequestDTO

  /// Creates a new `BudgetPlanCreationRequestDTO`.
  /// - Parameters:
  ///   - name: Name of the budget plan.
  ///   - openingDate: Date at which the budget plan is created.
  ///   - currency: Currency code the budget plan is expressed in.
  ///   - periodStartDay: Start day of the budget plan's period.
  ///   - recurrentBalance: Default value of a budget. (e.g.: salary)
  ///   - monthlyBudget: First monthly budget of the plan.
  public init(
    name: String,
    openingDate: Date,
    currency: String,
    periodStartDay: PeriodDayDTO,
    recurrentBalance: Decimal,
    monthlyBudget: MonthlyBudgetCreationRequestDTO
  ) {
    self.name = name
    self.openingDate = openingDate
    self.currency = currency
    self.periodStartDay = periodStartDay
    self.recurrentBalance = recurrentBalance
    self.monthlyBudget = monthlyBudget
  }
}

/// Request body describing the first monthly budget of a new plan.
public struct MonthlyBudgetCreationRequestDTO: DataSourceModel {
  public let startingBalance: Decimal
  public let periodStartDate: Date
  public let periodEndDate: Date

  /// Creates a new `MonthlyBudgetCreationRequestDTO`.
  /// - Parameters:
  ///   - startingBalance: Balance at the start of the period.
  ///   - periodStartDate: Start date of the period.
  ///   - periodEndDate: End date of the period.
  public init(
    startingBalance: Decimal,
    periodStartDate: Date,
    periodEndDate: Date
  ) {
    self.startingBalance = startingBalance
    self.periodStartDate = periodStartDate
    self.periodEndDate = periodEndDate
  }
}
