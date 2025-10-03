//
//  TransactionsListUIModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

enum TransactionsListUIModel: Equatable {
  case full([TransactionSectionUIModel])
  case compact([TransactionUIModel])
}
