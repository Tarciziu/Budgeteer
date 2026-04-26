//
//  TransactionDetailsUIMapper.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 02/04/2026.
//

import Foundation
import BTCore

struct TransactionDetailsUIMapper {
  // MARK: - Private Properties

  private let hyphenDateFormatter = DateFormatterStore().hyphenDateFormatter
  private let amountFormatter = NumberFormatterStore().amountFormatter

  // MARK: - Mapping Methods

  func mapParameters(transaction: TransactionDetailsUIModel) -> TransactionParametersDM {
    TransactionParametersDM(
      title: transaction.title,
      description: transaction.description,
      amount: mapAmount(transaction.amount),
      transactionDate: hyphenDateFormatter.date(from: transaction.transactionDate) ?? Date()
    )
  }

  func map(from transaction: TransactionDM) -> TransactionDetailsUIModel {
    TransactionDetailsUIModel(
      id: transaction.id,
      title: transaction.title,
      description: transaction.description ?? String(),
      amount: amountFormatter.string(for: transaction.amount) ?? String(),
      transactionDate: hyphenDateFormatter.string(from: transaction.transactionDate)
    )
  }

  func mapAmount(_ amount: String) -> Decimal {
    Decimal(string: amount, locale: amountFormatter.locale) ?? .zero
  }

  func makeEmptyTransactionModel() -> TransactionDetailsUIModel {
    TransactionDetailsUIModel(
      id: String(),
      title: String(),
      description: String(),
      amount: String(),
      transactionDate: String()
    )
  }
}
