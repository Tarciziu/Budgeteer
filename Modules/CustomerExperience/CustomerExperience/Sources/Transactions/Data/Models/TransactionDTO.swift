//
//  TransactionDTO.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 07.03.2026.
//

import Foundation
import SwiftData

@Model
public class TransactionDTO {
  var title: String
  var information: String?
  var amount: Decimal
  var transactionDate: Date

  public init(title: String, information: String? = nil, amount: Decimal, transactionDate: Date) {
    self.title = title
    self.information = information
    self.amount = amount
    self.transactionDate = transactionDate
  }
}
