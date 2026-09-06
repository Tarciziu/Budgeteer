//
//  PeriodDayDMTests.swift
//  BusinessCoreTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Testing
import BTBusinessCore

struct PeriodDayDMTests {
  @Test(
    "Maps a calendar day-of-month to the matching period start day",
    arguments: [
      (1, PeriodDayDM.day01),
      (5, PeriodDayDM.day05),
      (28, PeriodDayDM.day28)
    ]
  )
  func test_FromDayOfMonth_MapsExplicitDays(day: Int, expected: PeriodDayDM) {
    #expect(PeriodDayDM.from(dayOfMonth: day) == expected)
  }

  @Test(
    "Collapses days 29 to 31 to the last day of the month",
    arguments: [29, 30, 31]
  )
  func test_FromDayOfMonth_CollapsesTailDaysToLastDayOfMonth(day: Int) {
    #expect(PeriodDayDM.from(dayOfMonth: day) == .lastDayOfMonth)
  }
}
