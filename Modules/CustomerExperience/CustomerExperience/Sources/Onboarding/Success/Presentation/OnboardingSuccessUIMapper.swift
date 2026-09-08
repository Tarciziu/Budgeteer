//
//  OnboardingSuccessUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import BTCore
import BTBusinessCore

/// Builds the content for ``OnboardingSuccessUIModel`` from the budget plan that was just persisted.
struct OnboardingSuccessUIMapper {
  // MARK: - Private Properties

  private let dateFormatterStore = DateFormatterStore()
  private let amountFormatter = NumberFormatterStore().amountFormatter
  private let currencyMapper = CurrencyMapper()

  // MARK: - Internal Methods

  func map(
    plan: BudgetPlanDM,
    calendar: Calendar = .current,
    locale: Locale = .current
  ) -> OnboardingSuccessUIModel {
    OnboardingSuccessUIModel(
      title: LocalizedStrings.title,
      subtitle: LocalizedStrings.subtitle,
      rows: [
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.accountRowLabel,
          value: plan.name,
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.balanceRowLabel,
          value: formattedBalance(for: plan, locale: locale),
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.currencyRowLabel,
          value: currencyMapper.map(currency: plan.currency),
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.periodRowLabel,
          value: periodRangeText(for: plan, calendar: calendar, locale: locale),
          isHighlighted: true
        )
      ],
      primaryButtonTitle: LocalizedStrings.primaryButtonTitle
    )
  }
}

private extension OnboardingSuccessUIMapper {
  func formattedBalance(for plan: BudgetPlanDM, locale: Locale) -> String {
    amountFormatter.locale = locale
    let amount = plan.monthlyBudgets.first?.startingBalance ?? plan.recurrentBalance
    return amountFormatter.string(from: amount as NSDecimalNumber) ?? "\(amount)"
  }

  func periodRangeText(for plan: BudgetPlanDM, calendar: Calendar, locale: Locale) -> String {
    guard let period = plan.monthlyBudgets.first else { return String() }
    let formatter = dateFormatterStore.dayShortMonthFormatter(locale: locale)
    formatter.calendar = calendar
    formatter.timeZone = calendar.timeZone
    return "\(formatter.string(from: period.periodStartDate)) – \(formatter.string(from: period.periodEndDate))"
  }

  enum LocalizedStrings {
    static let title = Strings.CustomerExperience.singular("onboarding.success.title")
    static let subtitle = Strings.CustomerExperience.singular("onboarding.success.subtitle")
    static let accountRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.account")
    static let balanceRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.balance")
    static let currencyRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.currency")
    static let periodRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.period")
    static let primaryButtonTitle = Strings.CustomerExperience.singular("onboarding.success.cta")
  }
}
