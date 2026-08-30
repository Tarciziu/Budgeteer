//
//  TransactionDTO.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 07.03.2026.
//

import Foundation
import BTCore

public class TransactionDTO: DataSourceModel {
  public var id: String
  public var title: String
  public var information: String?
  public var amount: Decimal
  public var category: TransactionCategoryDTO
  public var transactionDate: Date

  public init(
    id: String,
    title: String,
    information: String? = nil,
    amount: Decimal,
    category: TransactionCategoryDTO,
    transactionDate: Date
  ) {
    self.id = id
    self.title = title
    self.information = information
    self.amount = amount
    self.category = category
    self.transactionDate = transactionDate
  }
}
