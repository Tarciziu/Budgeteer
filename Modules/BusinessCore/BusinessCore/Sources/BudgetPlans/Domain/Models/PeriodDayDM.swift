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
