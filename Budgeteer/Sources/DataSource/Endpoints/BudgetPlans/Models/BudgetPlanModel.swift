//
//  BudgetPlanModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import SwiftData
import BTCore

/// SwiftData model backing a stored budget plan.
///
/// The first monthly budget is stored inline: onboarding only ever creates a plan with a single
/// period and no feature reads historical periods yet. When multi-period support lands this should
/// grow a `MonthlyBudgetModel` relationship.
@Model
class BudgetPlanModel: DataSourceModel {
  var identifier: String = UUID().uuidString
  var name: String
  var openingDate: Date
  /// ISO currency code, e.g. `"RON"`.
  var currencyCode: String
  /// `PeriodDayDTO` raw value, e.g. `"DAY_08"`.
  var periodStartDayRaw: String
  var recurrentBalance: Decimal

  var monthlyIdentifier: String = UUID().uuidString
  var monthlyStartingBalance: Decimal
  var monthlyPeriodStartDate: Date
  var monthlyPeriodEndDate: Date

  init(
    name: String,
    openingDate: Date,
    currencyCode: String,
    periodStartDayRaw: String,
    recurrentBalance: Decimal,
    monthlyStartingBalance: Decimal,
    monthlyPeriodStartDate: Date,
    monthlyPeriodEndDate: Date
  ) {
    self.name = name
    self.openingDate = openingDate
    self.currencyCode = currencyCode
    self.periodStartDayRaw = periodStartDayRaw
    self.recurrentBalance = recurrentBalance
    self.monthlyStartingBalance = monthlyStartingBalance
    self.monthlyPeriodStartDate = monthlyPeriodStartDate
    self.monthlyPeriodEndDate = monthlyPeriodEndDate
  }
}
