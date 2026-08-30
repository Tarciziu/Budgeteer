//
//  MonthlyBudgetDM.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation

/// Domain representation of a monthly budget
public struct MonthlyBudgetDM: Identifiable, Equatable {
  /// Unique identifier of the budget.
  public let id: String
  /// Balence at the start of the period.
  public let startingBalance: Decimal
  /// Date representing the start date of the period.
  public let periodStartDate: Date
  /// Date representing the end date of the period.
  public let periodEndDate: Date

  /// Initializes a new ``MonthlyBudgetDM``.
  /// - Parameters:
  ///   - id: String representing the unique identifier of the budget.
  ///   - startingBalance: Decimal representing the balence at the start of the period.
  ///   - periodStartDate: Date representing the start date of the period.
  ///   - periodEndDate: Date representing the end date of the period.
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
