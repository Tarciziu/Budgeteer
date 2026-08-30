//
//  BudgetPlanRepository.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation

/// Main data layer entity used in the budget plans feature.
public protocol BudgetPlanRepository {
  /// Retrieves the list created budget plans, stored in the data base.
  /// - Returns: The list of stored budget plans on the device.
  func getBudgetPlans() async throws -> [BudgetPlanDM]

  /// Retrieves a budget plan based on its id.
  /// - Parameter id: Unique identifier of the budget plan.
  /// - Returns: The requested budget plan.
  func getBudgetPlan(id: String) async throws -> BudgetPlanDM

  /// Stores a new budget plan.
  /// - Parameter creationDM: The properties describing the budget plan to be created.
  /// - Returns: The persisted budget plan.
  @discardableResult
  func storeBudgetPlan(_ creationDM: BudgetPlanCreationDM) async throws -> BudgetPlanDM
}
