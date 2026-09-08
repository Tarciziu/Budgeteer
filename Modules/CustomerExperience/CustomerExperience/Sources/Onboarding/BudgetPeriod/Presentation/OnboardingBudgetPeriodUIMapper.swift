//
//  OnboardingBudgetPeriodUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import BTCore

/// Builds the content for ``OnboardingBudgetPeriodUIModel``.
///
/// The preview range is derived from the selected start date via ``OnboardingBudgetPeriodHelper`` so
/// the screen always matches the plan that gets persisted, and rendered here (not in the helper) via
/// ``DateFormatterStore``.
struct OnboardingBudgetPeriodUIMapper {
  // MARK: - Private Properties

  private let dateFormatterStore = DateFormatterStore()

  // MARK: - Internal Methods

  func map(
    startDate: Date,
    calendar: Calendar = .current,
    locale: Locale = .current
  ) -> OnboardingBudgetPeriodUIModel {
    let endDate = OnboardingBudgetPeriodHelper.endDate(from: startDate, calendar: calendar)

    return OnboardingBudgetPeriodUIModel(
      stepLabel: LocalizedStrings.stepLabel,
      progress: Constants.progress,
      title: LocalizedStrings.title,
      subtitle: LocalizedStrings.subtitle,
      startDateLabel: LocalizedStrings.startDateLabel,
      startDateText: fullDateText(for: startDate, calendar: calendar, locale: locale),
      previewCardLabel: LocalizedStrings.previewCardLabel,
      previewRangeText: rangeText(from: startDate, to: endDate, calendar: calendar, locale: locale),
      previewCaption: LocalizedStrings.previewCaption,
      primaryButtonTitle: LocalizedStrings.primaryButtonTitle,
      creationErrorTitle: LocalizedStrings.creationErrorTitle,
      creationErrorMessage: LocalizedStrings.creationErrorMessage,
      creationErrorDismissTitle: LocalizedStrings.creationErrorDismissTitle
    )
  }
}

private extension OnboardingBudgetPeriodUIMapper {
  func fullDateText(for date: Date, calendar: Calendar, locale: Locale) -> String {
    let formatter = dateFormatterStore.dayLongMonthYearFormatter(locale: locale)
    formatter.calendar = calendar
    formatter.timeZone = calendar.timeZone
    return formatter.string(from: date)
  }

  func rangeText(from start: Date, to end: Date, calendar: Calendar, locale: Locale) -> String {
    let formatter = dateFormatterStore.dayShortMonthFormatter(locale: locale)
    formatter.calendar = calendar
    formatter.timeZone = calendar.timeZone
    return "\(formatter.string(from: start)) – \(formatter.string(from: end))"
  }

  enum Constants {
    static let progress: CGFloat = 1.0
  }

  enum LocalizedStrings {
    static let stepLabel = Strings.CustomerExperience.singular("onboarding.budgetPeriod.stepLabel")
    static let title = Strings.CustomerExperience.singular("onboarding.budgetPeriod.title")
    static let subtitle = Strings.CustomerExperience.singular("onboarding.budgetPeriod.subtitle")
    static let startDateLabel = Strings.CustomerExperience.singular("onboarding.budgetPeriod.startDate.label")
    static let previewCardLabel = Strings.CustomerExperience.singular("onboarding.budgetPeriod.preview.label")
    static let previewCaption = Strings.CustomerExperience.singular("onboarding.budgetPeriod.preview.caption")
    static let primaryButtonTitle = Strings.CustomerExperience.singular("onboarding.budgetPeriod.cta")
    static let creationErrorTitle =
      Strings.CustomerExperience.singular("onboarding.budgetPeriod.creationError.title")
    static let creationErrorMessage =
      Strings.CustomerExperience.singular("onboarding.budgetPeriod.creationError.message")
    static let creationErrorDismissTitle =
      Strings.CustomerExperience.singular("onboarding.budgetPeriod.creationError.dismiss")
  }
}
