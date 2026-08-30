//
//  TransactionsDataMapper.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation
import BTCore

/// Type responsible for mapping transactions between data and domain layer.
struct TransactionsDataMapper {
  // MARK: - Mapping from data to domain layer

  func map(from transactions: [TransactionDTO]) -> [TransactionDM] {
    transactions.map { map(from: $0) }
  }

  func map(from transaction: TransactionDTO) -> TransactionDM {
    return TransactionDM(
      id: transaction.id,
      title: transaction.title,
      description: transaction.information,
      amount: transaction.amount,
      category: map(from: transaction.category),
      transactionDate: transaction.transactionDate
    )
  }

  func map(from category: TransactionCategoryDTO) -> TransactionCategoryDM {
    switch category {
    case .groceries:
      return .groceries
    case .bills:
      return .bills
    case .entertainment:
      return .entertainment
    case .salary:
      return .salary
    case .transport:
      return .transport
    case .health:
      return .health
    case .shopping:
      return .shopping
    case .other:
      return .other
    }
  }

  // MARK: - Mapping from domain to data layer

  func map(from parameters: TransactionParametersDM) -> TransactionCreationRequestDTO {
    TransactionCreationRequestDTO(
      title: parameters.title,
      information: parameters.description,
      amount: parameters.amount,
      category: map(from: parameters.category).rawValue,
      transactionDate: parameters.transactionDate
    )
  }

  func map(from category: TransactionCategoryDM) -> TransactionCategoryDTO {
    switch category {
    case .groceries:
      return .groceries
    case .bills:
      return .bills
    case .entertainment:
      return .entertainment
    case .salary:
      return .salary
    case .transport:
      return .transport
    case .health:
      return .health
    case .shopping:
      return .shopping
    case .other:
      return .other
    }
  }
}
