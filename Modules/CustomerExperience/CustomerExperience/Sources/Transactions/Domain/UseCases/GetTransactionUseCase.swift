//
//  GetTransactionUseCase.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 27/04/2026.
//


/// Protocol encapsulating the business logic for the `Get Transaction` use case.
public protocol GetTransactionUseCase {
  func getTransaction(id: String) async throws -> TransactionDM
}

/// Default implementation of the `GetTransactionUseCase`.
final public class DefaultGetTransactionUseCase: GetTransactionUseCase {
  // MARK: - Private Properties

  private let repository: TransactionsRepository

  // MARK: - Init

  /// Creates a new default implementation of ``GetTransactionUseCase``.
  /// - Parameter repository: Instance of ``TransactionsRepository``.
  public init(repository: TransactionsRepository) {
    self.repository = repository
  }

  // MARK: - GetTransactionUseCase Methods

  public func getTransaction(id: String) async throws -> TransactionDM {
    try await repository.getTransaction(id: id)
  }
}
