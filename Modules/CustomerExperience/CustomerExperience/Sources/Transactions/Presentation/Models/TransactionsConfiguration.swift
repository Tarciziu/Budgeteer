//
//  TransactionsConfiguration.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

/// Configuration object defining the style and behavior of the transactions list.
public struct TransactionsConfiguration {
  // MARK: - Nested Types

  /// Type defining the style of the transaction list.
  public enum TransactionListType {
    /// Full list of grouped transactions with sections for each day.
    case expanded
    /// Compact list with up to 5 transactions shown.
    case compact
  }

  /// The type of transaction list to be displayed.
  public let type: TransactionListType
  // TODO: Add more configuration options as needed in the future.

  /// Initializes a new instance of `TransactionsConfiguration`.
  /// - Parameter type: The type of transaction list to be displayed.
  public init(type: TransactionListType) {
    self.type = type
  }
}
