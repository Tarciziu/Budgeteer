//
//  TransactionFilter.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 29/04/2026.
//

import Foundation
import BTCore

/// Represents a filter that can be applied to the transactions list.
enum TransactionFilter: Identifiable, Equatable {
  case beforeDate(Date)
  case afterDate(Date)
  case betweenDates(start: Date, end: Date)
  case category(TransactionCategoryUIModel)

  var id: String {
    switch self {
    case .beforeDate:
      "beforeDate"
    case .afterDate:
      "afterDate"
    case .betweenDates:
      "betweenDates"
    case let .category(category):
      "category_\(category.type.rawValue)"
    }
  }

  var displayLabel: String {
    switch self {
    case let .beforeDate(date):
      return "\(TransactionFilterStrings.beforeLabel) \(Self.formatDate(date))"
    case let .afterDate(date):
      return "\(TransactionFilterStrings.afterLabel) \(Self.formatDate(date))"
    case let .betweenDates(start, end):
      return "\(Self.formatDate(start)) - \(Self.formatDate(end))"
    case let .category(category):
      return category.title
    }
  }

  private static func formatDate(_ date: Date) -> String {
    DateFormatterStore().hyphenDateFormatter.string(from: date)
  }
}

/// Defines the available date filter modes in the filter sheet.
enum DateFilterMode: Int, CaseIterable {
  case none
  case before
  case after
  case between

  var displayLabel: String {
    switch self {
    case .none: return TransactionFilterStrings.noneDateLabel
    case .before: return TransactionFilterStrings.beforeLabel
    case .after: return TransactionFilterStrings.afterLabel
    case .between: return TransactionFilterStrings.betweenLabel
    }
  }
}
