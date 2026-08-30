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
      category: categoryMapper.map(transaction.category),
      transactionDate: transaction.transactionDate
    )
  }

  // MARK: - UIModel to DM

  /// Maps the edited UI model into domain parameters.
  /// - Returns: `nil` when the model is missing a required field such as the category.
  func mapParameters(transaction: TransactionDetailsUIModel) -> TransactionParametersDM? {
    guard let category = transaction.category else { return nil }
    return TransactionParametersDM(
      title: transaction.title,
      description: transaction.description,
      amount: mapAmount(transaction.amount),
      category: categoryMapper.map(category),
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
      category: nil,
      transactionDate: Date.now
    )
  }
}
