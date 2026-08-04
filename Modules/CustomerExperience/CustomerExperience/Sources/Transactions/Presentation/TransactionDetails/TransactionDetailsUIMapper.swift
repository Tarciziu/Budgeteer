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

  private let categoryMapper = TransactionCategoryUIMapper()
  private let hyphenDateFormatter = DateFormatterStore().hyphenDateFormatter
  private let amountFormatter = NumberFormatterStore().amountFormatter

  // MARK: - DM to UIModel

  func map(from transaction: TransactionDM) -> TransactionDetailsUIModel {
    TransactionDetailsUIModel(
      id: transaction.id,
      title: transaction.title,
      description: transaction.description ?? String(),
      amount: amountFormatter.string(for: transaction.amount) ?? String(),
      categories: Set(categoryMapper.map(transaction.categories)),
      transactionDate: transaction.transactionDate
    )
  }

  // MARK: - UIModel to DM

  func mapParameters(transaction: TransactionDetailsUIModel) -> TransactionParametersDM {
    TransactionParametersDM(
      title: transaction.title,
      description: transaction.description,
      amount: mapAmount(transaction.amount),
      categories: categoryMapper.map(transaction.categories),
      transactionDate: transaction.transactionDate
    )
  }

  // MARK: - Mapping Methods

  func mapAmount(_ amount: String) -> Decimal {
    Decimal(string: amount, locale: amountFormatter.locale) ?? .zero
  }

  func makeEmptyTransactionModel() -> TransactionDetailsUIModel {
    TransactionDetailsUIModel(
      id: String(),
      title: String(),
      description: String(),
      amount: String(),
      categories: [],
      transactionDate: Date.now
    )
  }
}
