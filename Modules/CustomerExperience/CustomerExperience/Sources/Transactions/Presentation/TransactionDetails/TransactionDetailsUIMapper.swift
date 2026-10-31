//
//  TransactionDetailsUIMapper.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 02/04/2026.
//

import Foundation
import BTCore
import BTBusinessCore

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
      // The `TransactionDM` only carries the identifier; the name is resolved against the fetched
      // budget plans in `TransactionDetailsViewModel`.
      budgetPlan: TransactionBudgetPlanUIModel(id: transaction.budgetPlanId, name: String()),
      transactionDate: transaction.transactionDate
    )
  }

  func mapBudgetPlans(_ plans: [BudgetPlanDM]) -> [TransactionBudgetPlanUIModel] {
    plans.map { TransactionBudgetPlanUIModel(id: $0.id, name: $0.name) }
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
      transactionDate: transaction.transactionDate,
      budgetPlanId: transaction.budgetPlan.id
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
      budgetPlan: TransactionBudgetPlanUIModel(id: String(), name: String()),
      transactionDate: Date.now
    )
  }
}
