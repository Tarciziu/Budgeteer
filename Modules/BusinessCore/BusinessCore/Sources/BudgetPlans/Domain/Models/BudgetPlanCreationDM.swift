//
//  BudgetPlanCreationDM.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation

/// Business model encapsulating all properties necessary to create a budget plan.
public struct BudgetPlanCreationDM: Equatable {
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
  /// First monthly budget of the plan.
  public let monthlyBudget: MonthlyBudgetCreationDM

  /// Initializes a new ``BudgetPlanCreationDM``.
  /// - Parameters:
  ///   - name: String representing the name of the budget plan.
  ///   - openingDate: Date representing the moment of the plan's creation.
  ///   - currency: Currency of the Budget Plan.
  ///   - periodStartDay: Start day of the budget plan's period.
  ///   - recurrentBalance: Default value of a budget. (e.g.: salary)
  ///   - monthlyBudget: First monthly budget of the plan.
  public init(
    name: String,
    openingDate: Date,
    currency: CurrencyDM,
    periodStartDay: PeriodDayDM,
    recurrentBalance: Decimal,
    monthlyBudget: MonthlyBudgetCreationDM
  ) {
    self.name = name
    self.openingDate = openingDate
    self.currency = currency
    self.periodStartDay = periodStartDay
    self.recurrentBalance = recurrentBalance
    self.monthlyBudget = monthlyBudget
  }
}
