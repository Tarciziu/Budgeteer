//
//  TransactionModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11.03.2026.
//

import Foundation
import SwiftData
import BTCore

/// Type acting as a data model in the Swiftdata storage environment.
@Model
class TransactionModel: DataSourceModel {
  public var identifier: String = UUID().uuidString
  public var title: String
  public var information: String?
  public var amount: Decimal
  public var category: String
  public var transactionDate: Date

  public init(
    title: String,
    information: String? = nil,
    amount: Decimal,
    category: String,
    transactionDate: Date
  ) {
    self.title = title
    self.information = information
    self.amount = amount
    self.category = category
    self.transactionDate = transactionDate
  }
}
