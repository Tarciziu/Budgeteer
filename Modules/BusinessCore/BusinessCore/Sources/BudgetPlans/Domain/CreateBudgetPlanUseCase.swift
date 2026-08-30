//
//  CreateBudgetPlanUseCase.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

/// Protocol encapsulating the busines logic for the `CreateBudgetPlan` use case.
public protocol CreateBudgetPlanUseCase {
  func createBudgetPlan(_ creationDM: BudgetPlanCreationDM) async throws
}

/// Default implementation of the `CreateBudgetPlanUseCase`.
final public class DefaultCreateBudgetPlanUseCase: CreateBudgetPlanUseCase {
  // MARK: - CreateBudgetPlanUseCase Properties

  private let repository: BudgetPlanRepository

  // MARK: - Init

  /// Creates a new `DefaultCreateBudgetPlanUseCase`
  /// - Parameter repository: Repository used in the use case.
  public init(repository: BudgetPlanRepository) {
    self.repository = repository
  }

  // MARK: - CreateBudgetPlanUseCase Methods

  public func createBudgetPlan(_ creationDM: BudgetPlanCreationDM) async throws {
    try await repository.storeBudgetPlan(creationDM)
  }
}
