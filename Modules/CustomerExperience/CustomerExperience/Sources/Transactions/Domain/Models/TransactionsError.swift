//
//  TransactionsError.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 07.03.2026.
//

import Foundation

/// Error that may occur during transactions related operations.
public enum TransactionsError: Error {
  case network
  case missingData
  case missingDatabase
  case internalInconsistency
}
