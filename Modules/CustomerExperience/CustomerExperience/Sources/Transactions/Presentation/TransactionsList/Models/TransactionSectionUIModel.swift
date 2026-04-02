//
//  TransactionSectionUIModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

struct TransactionSectionUIModel: Equatable, Identifiable {
  let id = UUID().uuidString
  let title: String
  let transactions: [TransactionUIModel]
}
