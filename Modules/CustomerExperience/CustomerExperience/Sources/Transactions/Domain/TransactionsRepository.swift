//
//  TransactionsRepository.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

/// Repository handling transactions related operations.
public protocol TransactionsRepository {
  func getTransactions() throws -> [TransactionDM]
  @discardableResult
  func create(parameters: TransactionParametersDM) throws -> TransactionDM
  func delete(_ transaction: TransactionDM) throws
}
