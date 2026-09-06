//
//  OnboardingBudgetPeriodHelper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation

/// Shared source of the first budget period's dates.
///
/// The budget always starts the day after today and runs for one monthly period. Both
/// ``OnboardingSelectionDataProvider`` (when building the domain model) and
/// `OnboardingBudgetPeriodUIMapper` (when rendering the preview) derive their dates from here so the
/// screen and the persisted plan can never disagree. Rendering those dates as strings is the UI
/// mapper's job — this helper only returns `Date` values.
enum OnboardingBudgetPeriodHelper {
  /// The fixed start date for the first budget: the start of the day after `now`.
  static func startDate(now: Date = .now, calendar: Calendar = .current) -> Date {
    let today = calendar.startOfDay(for: now)
    return calendar.date(byAdding: .day, value: 1, to: today) ?? today
  }

  /// The inclusive end date of the first period: one month after `startDate`, minus a day
  /// (e.g. `5 July → 4 August`).
  static func endDate(from startDate: Date, calendar: Calendar = .current) -> Date {
    guard
      let monthLater = calendar.date(byAdding: .month, value: 1, to: startDate),
      let endDate = calendar.date(byAdding: .day, value: -1, to: monthLater)
    else {
      return startDate
    }
    return endDate
  }
}
