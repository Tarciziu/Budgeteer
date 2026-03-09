//
//  TransactionsInteractor.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

/// A protocol defining the interface for the Transactions interactor, responsible for handling use cases related to transactions.
public protocol TransactionsInteractor {
  func getTransactions() async throws -> [TransactionDM]
  @discardableResult
  func create(parameters: TransactionParametersDM) async throws -> TransactionDM
  func delete(_ transaction: TransactionDM) async throws
}
