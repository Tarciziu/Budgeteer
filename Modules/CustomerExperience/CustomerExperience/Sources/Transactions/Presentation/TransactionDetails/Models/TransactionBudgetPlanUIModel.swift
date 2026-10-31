//
//  TransactionBudgetPlanUIModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import Foundation

/// Presentation model for a budget plan the user can attach a transaction to.
struct TransactionBudgetPlanUIModel: Equatable, Identifiable {
  /// Unique identifier of the budget plan.
  let id: String
  /// Name of the budget plan, displayed in the selection list.
  let name: String
}
