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
  func map(selections: OnboardingSelections) -> OnboardingSuccessUIModel {
    OnboardingSuccessUIModel(
      title: Constants.title,
      subtitle: Constants.subtitle,
      rows: [
        OnboardingSuccessUIModel.Row(
          label: Constants.accountRowLabel,
          value: selections.accountName,
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: Constants.balanceRowLabel,
          value: selections.startingBalance,
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: Constants.currencyRowLabel,
          value: selections.currencyCode,
          isHighlighted: false
        ),
        OnboardingSuccessUIModel.Row(
          label: Constants.periodRowLabel,
          value: selections.periodRangeText,
          isHighlighted: true
        )
      ],
      primaryButtonTitle: Constants.primaryButtonTitle
    )
  }
}

private extension OnboardingSuccessUIMapper {
  enum Constants {
    static let title = Strings.CustomerExperience.singular("onboarding.success.title")
    static let subtitle = Strings.CustomerExperience.singular("onboarding.success.subtitle")
    static let accountRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.account")
    static let balanceRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.balance")
    static let currencyRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.currency")
    static let periodRowLabel = Strings.CustomerExperience.singular("onboarding.success.row.period")
    static let primaryButtonTitle = Strings.CustomerExperience.singular("onboarding.success.cta")
  }
}
