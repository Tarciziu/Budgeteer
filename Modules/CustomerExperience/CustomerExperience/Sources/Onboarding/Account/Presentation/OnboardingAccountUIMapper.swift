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
  // MARK: - Internal Methods

  func map() -> OnboardingAccountUIModel {
    OnboardingAccountUIModel(
      stepLabel: LocalizedStrings.stepLabel,
      progress: Constants.progress,
      title: LocalizedStrings.title,
      subtitle: LocalizedStrings.subtitle,
      nameFieldLabel: LocalizedStrings.nameFieldLabel,
      nameFieldPlaceholder: LocalizedStrings.nameFieldPlaceholder,
      balanceFieldLabel: LocalizedStrings.balanceFieldLabel,
      balanceFieldPlaceholder: LocalizedStrings.balanceFieldPlaceholder,
      currencyGroupLabel: LocalizedStrings.currencyGroupLabel,
      currencyCodes: Constants.currencyCodes,
      balanceErrorText: LocalizedStrings.balanceErrorText,
      primaryButtonTitle: LocalizedStrings.primaryButtonTitle,
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
    /// The balance is intentionally not pre-filled: the user must enter a positive amount before
    /// they can continue.
    static let defaultBalance = ""
    static let defaultCurrencyCode = "RON"
  }

  private enum LocalizedStrings {
    static let stepLabel = Strings.CustomerExperience.singular("onboarding.account.stepLabel")
    static let title = Strings.CustomerExperience.singular("onboarding.account.title")
    static let subtitle = Strings.CustomerExperience.singular("onboarding.account.subtitle")
    static let nameFieldLabel = Strings.CustomerExperience.singular("onboarding.account.nameField.label")
    static let nameFieldPlaceholder = Strings.CustomerExperience.singular("onboarding.account.nameField.placeholder")
    static let balanceFieldLabel = Strings.CustomerExperience.singular("onboarding.account.balanceField.label")
    static let balanceFieldPlaceholder =
    Strings.CustomerExperience.singular("onboarding.account.balanceField.placeholder")
    static let balanceErrorText = Strings.CustomerExperience.singular("onboarding.account.balanceField.error")
    static let currencyGroupLabel = Strings.CustomerExperience.singular("onboarding.account.currency.label")
    static let primaryButtonTitle = Strings.CustomerExperience.singular("onboarding.cta.continue")
  }
}
