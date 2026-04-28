//
//  TransactionsEndpointsID.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation

/// Type encapsulating identifiers for all endpoints responsible for the transactions list feature.
public enum TransactionsEndpointsID: String {
  case getTransactions
  case getTransaction
  case createTransaction
  case deleteTransaction
  case updateTransaction
}
