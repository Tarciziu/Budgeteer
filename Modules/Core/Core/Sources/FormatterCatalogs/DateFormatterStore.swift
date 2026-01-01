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
  }

  // MARK: - Public Properties

  /// Formatter focused on hyphen separated dates.
  /// The date format is "yyyy-MM-dd".
  public var hyphenDateFormatter: DateFormatter {
    makeHyphenDateFormatter()
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
}
