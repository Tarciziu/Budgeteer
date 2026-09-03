//
//  OnboardingAccountUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import BTCore

/// Builds the (dummy) content for ``OnboardingAccountUIModel``.
struct OnboardingAccountUIMapper {
  func map() -> OnboardingAccountUIModel {
    OnboardingAccountUIModel(
      stepLabel: Constants.stepLabel,
      progress: Constants.progress,
      title: Constants.title,
      subtitle: Constants.subtitle,
      nameFieldLabel: Constants.nameFieldLabel,
      nameFieldPlaceholder: Constants.nameFieldPlaceholder,
      balanceFieldLabel: Constants.balanceFieldLabel,
      balanceFieldPlaceholder: Constants.balanceFieldPlaceholder,
      currencyGroupLabel: Constants.currencyGroupLabel,
      currencyCodes: Constants.currencyCodes,
      primaryButtonTitle: Constants.primaryButtonTitle,
      defaultName: Constants.defaultName,
      defaultBalance: Constants.defaultBalance,
      defaultCurrencyCode: Constants.defaultCurrencyCode
    )
  }
}

private extension OnboardingAccountUIMapper {
  enum Constants {
    static let progress: CGFloat = 0.5
    static let currencyCodes = ["RON", "EUR", "USD", "GBP"]
    static let defaultName = "Cont principal"
    static let defaultBalance = "3.000"
    static let defaultCurrencyCode = "RON"

    static let stepLabel = Strings.CustomerExperience.singular("onboarding.account.stepLabel")
    static let title = Strings.CustomerExperience.singular("onboarding.account.title")
    static let subtitle = Strings.CustomerExperience.singular("onboarding.account.subtitle")
    static let nameFieldLabel = Strings.CustomerExperience.singular("onboarding.account.nameField.label")
    static let nameFieldPlaceholder = Strings.CustomerExperience.singular("onboarding.account.nameField.placeholder")
    static let balanceFieldLabel = Strings.CustomerExperience.singular("onboarding.account.balanceField.label")
    static let balanceFieldPlaceholder =
      Strings.CustomerExperience.singular("onboarding.account.balanceField.placeholder")
    static let currencyGroupLabel = Strings.CustomerExperience.singular("onboarding.account.currency.label")
    static let primaryButtonTitle = Strings.CustomerExperience.singular("onboarding.cta.continue")
  }
}
