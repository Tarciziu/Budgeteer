//
//  DateFormatterStore.swift
//  Core
//
//  Created by Tarciziu Gologan on 01.01.2026.
//

import Foundation

/// Store responsible for storing date formatters.
public class DateFormatterStore {
  // MARK: - Nested Types

  private enum Constants {
    static let hyphenDateFormat = "yyyy-MM-dd"
    static let longMonthYearDateFormat = "MMMM yyyy"
    static let longDateTimeFormat = "yyyy-MM-dd HH:mm"
  }

  // MARK: - Public Properties

  /// Formatter focused on hyphen separated dates.
  /// The date format is "yyyy-MM-dd".
  public var hyphenDateFormatter: DateFormatter {
    makeHyphenDateFormatter()
  }

  /// Formatter focused on month name and year  dates.
  /// The date format is "MMMM yyyy".
  public var longMonthYearDateFormatter: DateFormatter {
    makeLongMonthYearDateFormatter()
  }

  public var longDateTimeFormatter: DateFormatter {
    makeLongDateTimeFormatter()
  }

  // MARK: - Init

  /// Initializes a new ``DateFormatterStore``.
  public init() {
    /// Nothing to be initialized.
  }

  // MARK: - Private Factory Methods

  private func makeHyphenDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.hyphenDateFormat
    return formatter
  }

  private func makeLongMonthYearDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.longMonthYearDateFormat
    return formatter
  }

  private func makeLongDateTimeFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.longDateTimeFormat
    return formatter
  }
}
