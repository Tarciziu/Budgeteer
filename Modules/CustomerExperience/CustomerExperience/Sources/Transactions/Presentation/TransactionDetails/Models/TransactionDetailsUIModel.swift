//
//  TransactionDetailsUIModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 02/04/2026.
//

import Foundation

struct TransactionDetailsUIModel: Equatable {
  let id: String
  var title: String
  var description: String
  var amount: String
  var category: TransactionCategoryUIModel?
  var transactionDate: Date
}
