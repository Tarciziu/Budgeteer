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
  public var transactionDate: Date

  public init(
    title: String,
    information: String? = nil,
    amount: Decimal,
    transactionDate: Date
  ) {
    self.title = title
    self.information = information
    self.amount = amount
    self.transactionDate = transactionDate
  }
}
