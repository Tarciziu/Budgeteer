//
//  DateFormatterStoreTests.swift
//  CoreTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import Testing

@testable import BTCore

struct DateFormatterStoreTests {
  // MARK: - Constants

  private enum Constants {
    /// 2023-11-15 00:00:00 UTC.
    static let referenceDate = Date(timeIntervalSince1970: 1_700_006_400)
    static let locale = Locale(identifier: "en_US")
  }

  // MARK: - Private Properties

  private let store = DateFormatterStore()

  // MARK: - Tests

  @Test("The day / long month / year formatter renders a locale-ordered full date.")
  func test_DayLongMonthYearFormatter_RendersFullDate() {
    let formatter = store.dayLongMonthYearFormatter(locale: Constants.locale)
    formatter.timeZone = .gmt

    #expect(formatter.string(from: Constants.referenceDate) == "November 15, 2023")
  }

  @Test("The day / short month formatter renders an abbreviated day and month.")
  func test_DayShortMonthFormatter_RendersAbbreviatedDate() {
    let formatter = store.dayShortMonthFormatter(locale: Constants.locale)
    formatter.timeZone = .gmt

    #expect(formatter.string(from: Constants.referenceDate) == "Nov 15")
  }

  @Test("The day / long month / year formatter follows Romanian ordering for a Romanian locale.")
  func test_DayLongMonthYearFormatter_UsesRomanianOrdering() {
    let formatter = store.dayLongMonthYearFormatter(locale: Locale(identifier: "ro_RO"))
    formatter.timeZone = .gmt

    #expect(formatter.string(from: Constants.referenceDate) == "15 noiembrie 2023")
  }
}
