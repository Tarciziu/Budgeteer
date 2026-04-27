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
    let request = Request(id: TransactionsEndpointsID.getTransactions.rawValue)
    let result: [TransactionDTO]? = try await dataSource.executeRequest(request: request)
    return mapper.map(from: result ?? [])
  }

  public func getTransaction(id: String) async throws -> TransactionDM {
    let headers: [String: String] = [Constants.transactionIdentifierHeaderKey: id]
    let request = Request(id: TransactionsEndpointsID.getTransaction.rawValue, requestHeaders: headers)
    let result: [TransactionDTO]? = try await dataSource.executeRequest(request: request)
    guard let transaction = result?.first else {
      throw TransactionsError.missingData
    }
    return mapper.map(from: transaction)
  }

  // MARK: - Create

  public func create(parameters: TransactionParametersDM) async throws -> TransactionDM {
    let transaction = mapper.map(from: parameters)
    let request = Request(id: TransactionsEndpointsID.createTransaction.rawValue, body: transaction)
    let result: [TransactionDTO]? = try await dataSource.executeRequest(request: request)
    guard let createdTransaction = result?.first else {
      throw TransactionsError.internalInconsistency
    }
    return mapper.map(from: createdTransaction)
  }

  // MARK: - Update

  @discardableResult
  public func update(id: String, parameters: TransactionParametersDM) async throws -> TransactionDM {
    let body = mapper.map(from: parameters)
    let headers: [String: String] = [Constants.transactionIdentifierHeaderKey: id]
    let request = Request(
      id: TransactionsEndpointsID.updateTransaction.rawValue,
      body: body,
      requestHeaders: headers
    )
    let result: [TransactionDTO]? = try await dataSource.executeRequest(request: request)
    guard let updatedTransaction = result?.first else {
      throw TransactionsError.internalInconsistency
    }
    return mapper.map(from: updatedTransaction)
  }

  // MARK: - Delete

  public func delete(_ transactionId: String) async throws {
    // TODO: - Decide where the requests headers keys should be placed and documented.
    let headers: [String: String] = [Constants.transactionIdentifierHeaderKey: transactionId]
    let request = Request(id: TransactionsEndpointsID.deleteTransaction.rawValue, requestHeaders: headers)
    let _: [TransactionDTO]? = try await dataSource.executeRequest(request: request)
  }
}
