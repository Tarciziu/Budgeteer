//
//  CreateTransactionUseCase.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 28/03/2026.
//


/// Protocol encapsulating the business logic for the `Create Transaction` use case.
public protocol CreateTransactionUseCase {
  func createTransaction(_ creationDM: TransactionParametersDM) async throws
}

/// Default implementation of the `CreateTransactionUseCase`.
final public class DefaultCreateTransactionUseCase: CreateTransactionUseCase {
  // MARK: - GetRemindersUseCase Properties

  private let repository: TransactionsRepository

  // MARK: - Init

  /// Creates a new default implementation of ``CreateTransactionUseCase``.
  /// - Parameter repository: Instance of ``TransactionsRepository``.
  public init(repository: TransactionsRepository) {
    self.repository = repository
  }

  // MARK: - CreateTransactionUseCase Methods

  public func createTransaction(_ creationDM: TransactionParametersDM) async throws {
    try await repository.create(parameters: creationDM)
  }
}
