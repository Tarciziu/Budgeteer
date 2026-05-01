//
//  UpdateTransactionUseCase.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 27/04/2026.
//

/// Protocol encapsulating the business logic for the `Update Transaction` use case.
public protocol UpdateTransactionUseCase {
  func updateTransaction(id: String, parameters: TransactionParametersDM) async throws
}

/// Default implementation of the `UpdateTransactionUseCase`.
final public class DefaultUpdateTransactionUseCase: UpdateTransactionUseCase {
  // MARK: - Private Properties

  private let repository: TransactionsRepository

  // MARK: - Initializer

  /// Creates a new default implementation of ``UpdateTransactionUseCase``.
  /// - Parameter repository: Instance of ``TransactionsRepository``.
  public init(repository: TransactionsRepository) {
    self.repository = repository
  }

  // MARK: - UpdateTransactionUseCase Methods

  public func updateTransaction(id: String, parameters: TransactionParametersDM) async throws {
    try await repository.update(id: id, parameters: parameters)
  }
}
