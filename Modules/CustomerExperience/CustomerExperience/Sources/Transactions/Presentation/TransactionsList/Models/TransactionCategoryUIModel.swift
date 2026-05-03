//
//  TransactionCategoryUIModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 03/05/2026.
//

import Foundation

struct TransactionCategoryUIModel: Hashable {
  let type: CategoryType
  let title: String
}

extension TransactionCategoryUIModel {
  enum CategoryType: String, CaseIterable, Hashable {
    case groceries
    case bills
    case entertainment
    case salary
    case transport
    case health
    case shopping
    case other
  }
}
