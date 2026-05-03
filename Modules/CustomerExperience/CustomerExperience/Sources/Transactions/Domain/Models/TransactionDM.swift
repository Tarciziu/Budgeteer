//
//  TransactionDM.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 07.03.2026.
//

import Foundation

/// Domain model representing a transaction.
public struct TransactionDM: Identifiable, Equatable {
  /// Unique identifier of a transaction.
  public let id: String
  /// Title of a transaction.
  public let title: String
  /// Description of the transaction.
  public let description: String?
  /// Positive or negative amount of a transaction.
  public let amount: Decimal
  /// Categories of the transaction.
  public let categories: [TransactionCategoryDM]
  /// Transaction's date.
  public let transactionDate: Date

  /// Initializes a new instance of `TransactionDM`.
  /// - Parameters:
  ///   - id: Unique identifier of a transaction.
  ///   - title: Title of a transaction.
  ///   - description: Description of the transaction.
  ///   - amount: Positive or negative amount of a transaction.
  ///   - categories: Categories of the transaction.
  ///   - transactionDate: Transaction's date.
  public init(
    id: String,
    title: String,
    description: String?,
    amount: Decimal,
    categories: [TransactionCategoryDM],
    transactionDate: Date
  ) {
    self.id = id
    self.title = title
    self.description = description
    self.amount = amount
    self.categories = categories
    self.transactionDate = transactionDate
  }
}
