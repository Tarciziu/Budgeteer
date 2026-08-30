//
//  TransactionCreationRequestDTO.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation
import BTCore

public class TransactionCreationRequestDTO: DataSourceModel {
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
