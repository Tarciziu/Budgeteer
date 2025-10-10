//
//  TransactionUIModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

struct TransactionUIModel: Identifiable, Equatable {
  let id = UUID().uuidString
  /// Title of a transaction.
  let title: String
  /// Description of the transaction.
  let subtitle: String?
  /// Positive or negative amount of a transaction.
  let amount: String
  /// Indicates if the amount is positive or negative.
  let isPositiveAmount: Bool
  /// Transaction date in case of compact layout or nothing in case of expanded layout.
  let transactionDate: String?

  init(title: String, subtitle: String? = nil, amount: String, isPositiveAmount: Bool, transactionDate: String? = nil) {
    self.title = title
    self.subtitle = subtitle
    self.amount = amount
    self.isPositiveAmount = isPositiveAmount
    self.transactionDate = transactionDate
  }
}
