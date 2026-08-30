//
//  GetBudgetPlanUseCase.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

/// Protocol encapsulating the busines logic for the `GetBudgetPlan` use case.
public protocol GetBudgetPlanUseCase {
  func getBudgetPlan(id: String) async throws -> BudgetPlanDM
}

/// Default implementation of the `GetBudgetPlanUseCase`.
final public class DefaultGetBudgetPlanUseCase: GetBudgetPlanUseCase {
  // MARK: - GetBudgetPlanUseCase Properties

  private let repository: BudgetPlanRepository

  // MARK: - Init

  /// Creates a new `DefaultGetBudgetPlanUseCase`
  /// - Parameter repository: Repository used in the use case.
  public init(repository: BudgetPlanRepository) {
    self.repository = repository
  }

  // MARK: - GetBudgetPlanUseCase Methods

  public func getBudgetPlan(id: String) async throws -> BudgetPlanDM {
    try await repository.getBudgetPlan(id: id)
  }
}
