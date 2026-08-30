//
//  PeriodDayDTOTests.swift
//  CustomerExperienceTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Testing
@testable import BTCustomerExperience

struct PeriodDayDTOTests {
  @Test("Encodes the fixed day cases with their DAY_xx string")
  func test_RawValues_FixedDays() {
    #expect(PeriodDayDTO.day01.rawValue == "DAY_01")
    #expect(PeriodDayDTO.day05.rawValue == "DAY_05")
    #expect(PeriodDayDTO.day09.rawValue == "DAY_09")
    #expect(PeriodDayDTO.day28.rawValue == "DAY_28")
  }

  @Test("Encodes the end of month case as DAY_LAST")
  func test_RawValue_LastDayOfMonth() {
    #expect(PeriodDayDTO.lastDayOfMonth.rawValue == "DAY_LAST")
  }

  @Test("Covers days 1 through 28 plus the end of month, in order")
  func test_AllCases() {
    #expect(PeriodDayDTO.allCases.count == 29)
    #expect(PeriodDayDTO.allCases.first == .day01)
    #expect(PeriodDayDTO.allCases.last == .lastDayOfMonth)

    for day in PeriodDayDTO.allCases where day != .lastDayOfMonth {
      // Every numbered day is `DAY_` followed by a zero-padded two digit number.
      #expect(day.rawValue.hasPrefix("DAY_"))
      #expect(day.rawValue.count == "DAY_00".count)
    }
  }

  @Test("Can be rebuilt from its stored string")
  func test_InitFromRawValue() {
    #expect(PeriodDayDTO(rawValue: "DAY_08") == .day08)
    #expect(PeriodDayDTO(rawValue: "DAY_LAST") == .lastDayOfMonth)
    #expect(PeriodDayDTO(rawValue: "DAY_31") == nil)
  }
}
