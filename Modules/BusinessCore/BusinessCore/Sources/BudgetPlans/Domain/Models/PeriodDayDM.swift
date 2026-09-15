//
//  PeriodDayDM.swift
//  BusinessCore
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation

/// Type representing the possible starting day of a period.
///
/// A period can start on any day from the 1st to the 28th (days that exist in every month),
/// or on the last day of the month. The set is closed, hence `@frozen`.
@frozen
public enum PeriodDayDM {
  case day01
  case day02
  case day03
  case day04
  case day05
  case day06
  case day07
  case day08
  case day09
  case day10
  case day11
  case day12
  case day13
  case day14
  case day15
  case day16
  case day17
  case day18
  case day19
  case day20
  case day21
  case day22
  case day23
  case day24
  case day25
  case day26
  case day27
  case day28
  case lastDayOfMonth
}

public extension PeriodDayDM {
  /// Maps a calendar day-of-month (`1...31`) to a period start day.
  ///
  /// Only the 1st to the 28th are represented explicitly, so days `29`, `30` and `31`
  /// collapse to ``lastDayOfMonth``.
  /// - Parameter day: The calendar day-of-month, as returned by `Calendar.component(.day, from:)`.
  /// - Returns: The matching ``PeriodDayDM``.
  static func from(dayOfMonth day: Int) -> PeriodDayDM {
    byDayOfMonth[day] ?? .lastDayOfMonth
  }

  private static let byDayOfMonth: [Int: PeriodDayDM] = [
    1: .day01, 2: .day02, 3: .day03, 4: .day04, 5: .day05, 6: .day06, 7: .day07,
    8: .day08, 9: .day09, 10: .day10, 11: .day11, 12: .day12, 13: .day13, 14: .day14,
    15: .day15, 16: .day16, 17: .day17, 18: .day18, 19: .day19, 20: .day20, 21: .day21,
    22: .day22, 23: .day23, 24: .day24, 25: .day25, 26: .day26, 27: .day27, 28: .day28
  ]
}
