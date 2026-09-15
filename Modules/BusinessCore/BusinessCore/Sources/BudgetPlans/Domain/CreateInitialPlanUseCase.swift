//
//  CreateInitialPlanUseCase.swift
//  BusinessCore
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

/// Protocol encapsulating the busines logic for the `CreateInitialPlan` use case.
///
/// Used by the onboarding flow to persist the very first budget plan the user configures.
public protocol CreateInitialPlanUseCase {
  /// Persists the initial budget plan.
  /// - Parameter creationDM: The properties describing the budget plan to be created.
  /// - Returns: The persisted budget plan.
  @discardableResult
  func createInitialPlan(_ creationDM: BudgetPlanCreationDM) async throws -> BudgetPlanDM
}

/// Default implementation of the `CreateInitialPlanUseCase`.
final public class DefaultCreateInitialPlanUseCase: CreateInitialPlanUseCase {
  // MARK: - CreateInitialPlanUseCase Properties

  private let repository: BudgetPlanRepository

  // MARK: - Init

  /// Creates a new `DefaultCreateInitialPlanUseCase`
  /// - Parameter repository: Repository used to persist the budget plan.
  public init(repository: BudgetPlanRepository) {
    self.repository = repository
  }

  // MARK: - CreateInitialPlanUseCase Methods

  @discardableResult
  public func createInitialPlan(_ creationDM: BudgetPlanCreationDM) async throws -> BudgetPlanDM {
    try await repository.storeBudgetPlan(creationDM)
  }
}
