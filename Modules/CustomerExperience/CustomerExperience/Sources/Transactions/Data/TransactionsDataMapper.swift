//
//  TransactionsDataMapper.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation
import SwiftData
import BTCore

/// Type responsible for mapping transactions between data and domain layer.
struct TransactionsDataMapper {
  // MARK: - Private Properties

  let jsonEncoder = JSONEncoder()

  // MARK: - Mapping from data to domain layer

  func map(from transactions: [TransactionDTO]) throws -> [TransactionDM] {
    try transactions.map { try map(from: $0) }
  }

  func map(from transaction: TransactionDTO) throws -> TransactionDM {
    guard
      let identifierData = try? jsonEncoder.encode(transaction.persistentModelID),
      let identifierString = String(data: identifierData, encoding: .utf8)
    else {
      throw TransactionsError.internalInconsistency
    }
    return TransactionDM(
      id: identifierString,
      title: transaction.title,
      description: transaction.information,
      amount: transaction.amount,
      transactionDate: transaction.transactionDate
    )
  }

  // MARK: - Mapping from domain to data layer

  func map(from parameters: TransactionParametersDM) -> TransactionDTO {
    TransactionDTO(
      title: parameters.title,
      information: parameters.description,
      amount: parameters.amount,
      transactionDate: parameters.transactionDate
    )
  }

  func map(from transaction: TransactionDM) throws -> PersistentIdentifier {
    guard let data = transaction.id.data(using: .utf8) else {
      throw TransactionsError.internalInconsistency
    }
    do {
      return try JSONDecoder().decode(PersistentIdentifier.self, from: data)
    } catch {
      throw TransactionsError.internalInconsistency
    }
  }
}
