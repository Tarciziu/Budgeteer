//
//  GetTransactionsUseCase.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 28/03/2026.
//


/// Protocol encapsulating the business logic for the `Get Transactions` use case.
public protocol GetTransactionsUseCase {
  func getTransactions() async throws -> [TransactionDM]
}

/// Default implementation of the `GetTransactionsUseCase`.
final public class DefaultGetTransactionsUseCase: GetTransactionsUseCase {
  // MARK: - GetRemindersUseCase Properties

  private let repository: TransactionsRepository

  // MARK: - Init

  /// Creates a new default implementation of ``GetTransactionsUseCase``.
  /// - Parameter repository: Instance of ``TransactionsRepository``.
  public init(repository: TransactionsRepository) {
    self.repository = repository
  }

  // MARK: - GetTransactionsUseCase Methods

  public func getTransactions() async throws -> [TransactionDM] {
    try await repository.getTransactions()
  }
}
