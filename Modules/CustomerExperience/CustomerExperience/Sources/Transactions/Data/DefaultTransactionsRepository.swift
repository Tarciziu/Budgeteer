//
//  DefaultTransactionsRepository.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import BTCore

/// The default implementation of ``TransactionsRepository``.
public class DefaultTransactionsRepository: TransactionsRepository {
  // MARK: - Nested Types

  enum Constants {
    static let transactionIdentifierHeaderKey = "txId"
  }

  // MARK: - Private Properties

  private let dataSource: DataSource
  private let mapper = TransactionsDataMapper()

  // MARK: - Initializer

  /// Creates a new instance of ``DefaultTransactionsRepository``.
  /// - Parameter dataSource: Instance of ``DataSource``.
  public init(dataSource: DataSource) {
    self.dataSource = dataSource
  }

  // MARK: - Read

  public func getTransactions() async throws -> [TransactionDM] {
    let request = Request(id: TransactionsEndpointsID.getTransacitons.rawValue)
    let result: Result<[TransactionDTO]?, DataSourceError> = try await dataSource.executeRequest(request: request)

    switch result {
    case .success(let data):
      return mapper.map(from: data ?? [])
    case .failure:
      throw TransactionsError.internalInconsistency
    }
  }

  // MARK: - Create

  public func create(parameters: TransactionParametersDM) async throws -> TransactionDM {
    let transaction = mapper.map(from: parameters)
    let request = Request(id: TransactionsEndpointsID.createTransaction.rawValue, body: transaction)
    let result: Result<[TransactionDTO]?, DataSourceError> = try await dataSource.executeRequest(request: request)

    switch result {
    case .success(let data):
      if let createdTransaction = data?.first {
        return mapper.map(from: createdTransaction)
      }
    case .failure:
      throw TransactionsError.internalInconsistency
    }
    throw TransactionsError.internalInconsistency
  }

  // MARK: - Delete

  public func delete(_ transaction: TransactionDM) async throws {
    // TODO: - Decide where the requests headers keys should be placed and documented.
    let headers: [String: String] = [Constants.transactionIdentifierHeaderKey: transaction.id]
    let request = Request(id: TransactionsEndpointsID.deleteTransaction.rawValue, requestHeaders: headers)
    let result: Result<[TransactionDTO]?, DataSourceError> = try await dataSource.executeRequest(request: request)

    switch result {
    case .success:
      return
    case .failure:
      throw TransactionsError.internalInconsistency
    }
  }
}
