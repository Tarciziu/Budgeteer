//
//  DefaultTransactionsInteractor.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 03.10.2025.
//

import Foundation

/// Default implementation of `TransactionsInteractor`.
public class DefaultTransactionsInteractor: TransactionsInteractor {
  // MARK: - Private Properties

  private let transactionsRepository: TransactionsRepository

  // MARK: - Initializer

  /// Initializes a new instance of `DefaultTransactionsInteractor`.
  /// - Parameter transactionsRepository: Instance of ``TransactionsRepository``.
  public init(transactionsRepository: TransactionsRepository) {
    self.transactionsRepository = transactionsRepository
  }

  // MARK: - TransactionsInteractor conformance

  public func getTransactions() async throws -> [TransactionDM] {
    try await transactionsRepository.getTransactions()
  }

  @discardableResult
  public func create(parameters: TransactionParametersDM) async throws -> TransactionDM {
    try await transactionsRepository.create(parameters: parameters)
  }

  public func delete(_ transaction: TransactionDM) async throws {
    try await transactionsRepository.delete(transaction)
  }
}
