//
//  ServiceDateFormatterStore.swift
//  Core
//
//  Created by Tarciziu Gologan on 01.01.2026.
//

import Foundation

/// Store responsible for managing service date formatters.
public class ServiceDateFormatterStore {
  // MARK: - Nested Types

  private enum Constants {
    static let utcDateFormat = "yyyy.MM.dd'T'HH:mm:ssZ"
  }

  // MARK: - Public Properties

  /// Formatter for UTC date and time values with dot-separated date components.
  /// The date format is "yyyy.MM.ddTHH:mm:ssZ".
  public lazy private(set) var utcDateFormatter: DateFormatter = {
    makeUtcDateFormatter()
  }()

  // MARK: - Init

  /// Initializes a new ``ServiceDateFormatterStore``.
  public init() {
    /// Nothing to be initialized.
  }

  // MARK: - Private Factory Methods

  private func makeUtcDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.utcDateFormat
    return formatter
  }
}
