//
//  TransactionCategoryDM.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 29/04/2026.
//

import Foundation
import BTCore

/// Predefined categories for classifying transactions.
public enum TransactionCategoryDM: CaseIterable, Equatable, Sendable {
  case groceries
  case bills
  case entertainment
  case salary
  case transport
  case health
  case shopping
  case other
}
