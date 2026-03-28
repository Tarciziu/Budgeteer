//
//  TransactionsRepository.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

/// Repository handling transactions related operations.
public protocol TransactionsRepository {
  func getTransactions() async throws -> [TransactionDM]
  @discardableResult
  func create(parameters: TransactionParametersDM) async throws -> TransactionDM
  func delete(_ transactionId: String) async throws
}
