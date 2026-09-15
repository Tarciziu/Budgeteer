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
    static let dayLongMonthYearTemplate = "d MMMM yyyy"
    static let dayShortMonthTemplate = "d MMM"
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

  /// Formatter for a full day / month / year date, ordered per `locale`
  /// (e.g. "November 15, 2023" in English, "15 noiembrie 2023" in Romanian).
  /// Built from the "d MMMM yyyy" template.
  /// - Parameter locale: Locale that drives the component ordering. Defaults to `.current`.
  public func dayLongMonthYearFormatter(locale: Locale = .current) -> DateFormatter {
    makeTemplateFormatter(with: Constants.dayLongMonthYearTemplate, locale: locale)
  }

  /// Formatter for an abbreviated day / month date (e.g. "Nov 15" / "15 nov."),
  /// used for compact period ranges. Built from the "d MMM" template.
  /// - Parameter locale: Locale that drives the component ordering. Defaults to `.current`.
  public func dayShortMonthFormatter(locale: Locale = .current) -> DateFormatter {
    makeTemplateFormatter(with: Constants.dayShortMonthTemplate, locale: locale)
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

  private func makeTemplateFormatter(with template: String, locale: Locale) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.setLocalizedDateFormatFromTemplate(template)
    return formatter
  }
}
