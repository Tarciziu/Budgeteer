//
//  MonthlyBudgetCreationDM.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation

/// Domain representation of a monthly budget
public struct MonthlyBudgetCreationDM: Equatable {
  /// Balence at the start of the period.
  public let startingBalance: Decimal
  /// Current balence of the budget period.
  public let currentBalance: Decimal
  /// Date representing the start date of the period.
  public let periodStartDate: Date
  /// Date representing the end date of the period.
  public let periodEndDate: Date

  /// Initializes a new ``MonthlyBudgetDM``.
  /// - Parameters:
  ///   - startingBalance: Decimal representing the balence at the start of the period.
  ///   - currentBalance: Decimal representing the current balence of the budget period.
  ///   - periodStartDate: Date representing the start date of the period.
  ///   - periodEndDate: Date representing the end date of the period.
  public init(
    startingBalance: Decimal,
    currentBalance: Decimal,
    periodStartDate: Date,
    periodEndDate: Date
  ) {
    self.startingBalance = startingBalance
    self.currentBalance = currentBalance
    self.periodStartDate = periodStartDate
    self.periodEndDate = periodEndDate
  }
}
