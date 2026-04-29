//
//  TransactionUIModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

struct TransactionUIModel: Identifiable, Equatable {
  let id: String
  /// Title of a transaction.
  let title: String
  /// Category label of the transaction.
  let categories: String
  /// Positive or negative amount of a transaction.
  let amount: String
  /// Indicates if the amount is positive or negative.
  let isPositiveAmount: Bool
  /// Transaction date in case of compact layout or nothing in case of expanded layout.
  let transactionDate: String?

  init(
    id: String,
    title: String,
    categories: String,
    amount: String,
    isPositiveAmount: Bool,
    transactionDate: String? = nil
  ) {
    self.id = id
    self.title = title
    self.categories = categories
    self.amount = amount
    self.isPositiveAmount = isPositiveAmount
    self.transactionDate = transactionDate
  }
}
