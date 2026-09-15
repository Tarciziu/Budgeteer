//
//  CurrencyMapperTests.swift
//  BusinessCoreTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Testing
import BTBusinessCore

struct CurrencyMapperTests {
  // MARK: - Private Properties

  private let mapper = CurrencyMapper()

  // MARK: - Tests

  @Test(
    "Maps a currency to its ISO code",
    arguments: [
      (CurrencyDM.eur, "EUR"),
      (CurrencyDM.usd, "USD"),
      (CurrencyDM.ron, "RON"),
      (CurrencyDM.gbp, "GBP")
    ]
  )
  func test_MapCurrencyToCode(currency: CurrencyDM, expectedCode: String) {
    #expect(mapper.map(currency: currency) == expectedCode)
  }

  @Test(
    "Maps an ISO code back to its currency",
    arguments: [
      ("EUR", CurrencyDM.eur),
      ("USD", CurrencyDM.usd),
      ("RON", CurrencyDM.ron),
      ("GBP", CurrencyDM.gbp)
    ]
  )
  func test_MapCodeToCurrency(code: String, expectedCurrency: CurrencyDM) {
    #expect(mapper.map(currency: code) == expectedCurrency)
  }

  @Test("Returns nil for an unknown currency code")
  func test_MapUnknownCode_ReturnsNil() {
    #expect(mapper.map(currency: "CHF") == nil)
  }
}
