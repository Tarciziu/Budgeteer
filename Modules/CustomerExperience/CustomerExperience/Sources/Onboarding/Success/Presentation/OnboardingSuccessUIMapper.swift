//
//  OnboardingSuccessUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import BTCore

/// Builds the content for ``OnboardingSuccessUIModel`` from the values collected during the flow.
struct OnboardingSuccessUIMapper {
  // MARK: - Internal Methods

  func map(selections: OnboardingSelections) -> OnboardingSuccessUIModel {
    OnboardingSuccessUIModel(
      title: LocalizedStrings.title,
      subtitle: LocalizedStrings.subtitle,
      rows: [
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.accountRowLabel,
          value: selections.accountName,
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.balanceRowLabel,
          value: selections.startingBalance,
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.currencyRowLabel,
          value: selections.currencyCode,
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: LocalizedStrings.periodRowLabel,
          value: selections.periodRangeText,
          isHighlighted: true
        )
      ],
      primaryButtonTitle: LocalizedStrings.primaryButtonTitle
    )
  }
}

private extension OnboardingSuccessUIMapper {
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
