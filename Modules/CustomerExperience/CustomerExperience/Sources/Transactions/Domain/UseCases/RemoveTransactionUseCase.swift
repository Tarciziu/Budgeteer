//
//  RemoveTransactionUseCase.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 28/03/2026.
//


/// Protocol encapsulating the business logic for the `Remove Transaction` use case.
public protocol RemoveTransactionUseCase {
  func removeTransaction(transactionId: String) async throws
}

/// Default implementation of the `RemoveTransactionUseCase`.
final public class DefaultRemoveTransactionUseCase: RemoveTransactionUseCase {
  // MARK: - GetRemindersUseCase Properties

  private let repository: TransactionsRepository

  // MARK: - Init

  /// Creates a new default implementation of ``RemoveTransactionUseCase``.
  /// - Parameter repository: Instance of ``TransactionsRepository``.
  public init(repository: TransactionsRepository) {
    self.repository = repository
  }

  // MARK: - RemoveTransactionUseCase Methods

  public func removeTransaction(transactionId: String) async throws {
    try await repository.delete(transactionId)
  }
}
