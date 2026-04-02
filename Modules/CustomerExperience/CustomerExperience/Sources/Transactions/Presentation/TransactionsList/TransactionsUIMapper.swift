//
//  TransactionsUIMapper.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation
import BTCore

struct TransactionsUIMapper {
  // MARK: - Private Properties

  let hyphenDateFormatter = DateFormatterStore().hyphenDateFormatter
  let longMonthYearDateFormatter = DateFormatterStore().longMonthYearDateFormatter
  let amountFormatter = NumberFormatterStore().amountFormatter

  // MARK: - Map from domain to UIModel

  func map(transactions: [TransactionDM]) -> [TransactionSectionUIModel] {
    var groupedTransactions: [TransactionSectionUIModel] = []
    var todayTransactions: [TransactionDM] = []
    var yesterdayTransactions: [TransactionDM] = []
    var olderTransactions: [String: [TransactionDM]] = [:]
    var olderTransactionsOrder: [String] = []

    let sortedTransactions = transactions.sorted { $0.transactionDate > $1.transactionDate }
    sortedTransactions.forEach { transaction in
      if Calendar.current.isDateInToday(transaction.transactionDate) {
        todayTransactions.append(transaction)
      } else if Calendar.current.isDateInYesterday(transaction.transactionDate) {
        yesterdayTransactions.append(transaction)
      } else {
        let dateKey = longMonthYearDateFormatter.string(from: transaction.transactionDate)
        if olderTransactions[dateKey] == nil {
          olderTransactions[dateKey] = [transaction]
          olderTransactionsOrder.append(dateKey)
        } else {
          olderTransactions[dateKey]?.append(transaction)
        }
      }
    }

    [ (todayTransactions, "Today"), (yesterdayTransactions, "Yesterday") ].forEach { transactions, title in
      if !transactions.isEmpty {
        groupedTransactions.append(TransactionSectionUIModel(title: title, transactions: transactions.map(map)))
      }
    }

    olderTransactionsOrder.forEach { dateKey in
      if let transactions = olderTransactions[dateKey] {
        groupedTransactions.append(TransactionSectionUIModel(title: dateKey, transactions: transactions.map(map)))
      }
    }

    return groupedTransactions
  }

  func map(transaction: TransactionDM) -> TransactionUIModel {
    TransactionUIModel(
      id: transaction.id,
      title: transaction.title,
      subtitle: transaction.description,
      amount: mapAmount(transaction.amount),
      isPositiveAmount: transaction.amount >= .zero,
      transactionDate: hyphenDateFormatter.string(from: transaction.transactionDate)
    )
  }

  func mapAmount(_ amount: Decimal) -> String {
    amountFormatter.string(from: amount as NSDecimalNumber) ?? String()
  }

  // MARK: - Map from UIModel to domain

  func map(transaction: TransactionUIModel) -> TransactionDM {
    TransactionDM(
      id: transaction.id,
      title: transaction.title,
      description: transaction.subtitle,
      amount: mapAmount(transaction.amount),
      transactionDate: hyphenDateFormatter.date(from: transaction.transactionDate ?? String()) ?? Date()
    )
  }

  func mapAmount(_ amount: String) -> Decimal {
    Decimal(string: amount, locale: amountFormatter.locale) ?? .zero
  }
}
