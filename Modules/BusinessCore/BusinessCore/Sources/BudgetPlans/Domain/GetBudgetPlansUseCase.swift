//
//  GetBudgetPlansUseCase.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

/// Protocol encapsulating the busines logic for the `GetBudgetPlans` use case.
public protocol GetBudgetPlansUseCase {
  func getBudgetPlans() async throws -> [BudgetPlanDM]
}

/// Default implementation of the `GetBudgetPlansUseCase`.
final public class DefaultGetBudgetPlansUseCase: GetBudgetPlansUseCase {
  // MARK: - GetBudgetPlansUseCase Properties

  private let repository: BudgetPlanRepository

  // MARK: - Init

  /// Creates a new `DefaultGetBudgetPlansUseCase`
  /// - Parameter repository: Repository used in the use case.
  public init(repository: BudgetPlanRepository) {
    self.repository = repository
  }

  // MARK: - GetBudgetPlansUseCase Methods

  public func getBudgetPlans() async throws -> [BudgetPlanDM] {
    try await repository.getBudgetPlans()
  }
}
