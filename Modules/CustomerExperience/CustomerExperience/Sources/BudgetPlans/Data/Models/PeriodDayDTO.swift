//
//  PeriodDayDTO.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import BTCore

/// Data transfer representation of `PeriodDayDM`.
///
/// Persisted in the data source as a string such as `"DAY_01"` … `"DAY_28"` or `"DAY_LAST"`.
public enum PeriodDayDTO: String, CaseIterable, DataSourceModel {
  case day01 = "DAY_01"
  case day02 = "DAY_02"
  case day03 = "DAY_03"
  case day04 = "DAY_04"
  case day05 = "DAY_05"
  case day06 = "DAY_06"
  case day07 = "DAY_07"
  case day08 = "DAY_08"
  case day09 = "DAY_09"
  case day10 = "DAY_10"
  case day11 = "DAY_11"
  case day12 = "DAY_12"
  case day13 = "DAY_13"
  case day14 = "DAY_14"
  case day15 = "DAY_15"
  case day16 = "DAY_16"
  case day17 = "DAY_17"
  case day18 = "DAY_18"
  case day19 = "DAY_19"
  case day20 = "DAY_20"
  case day21 = "DAY_21"
  case day22 = "DAY_22"
  case day23 = "DAY_23"
  case day24 = "DAY_24"
  case day25 = "DAY_25"
  case day26 = "DAY_26"
  case day27 = "DAY_27"
  case day28 = "DAY_28"
  case lastDayOfMonth = "DAY_LAST"
}
