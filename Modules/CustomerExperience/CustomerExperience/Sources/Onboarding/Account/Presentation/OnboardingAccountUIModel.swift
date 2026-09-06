//
//  OnboardingAccountUIModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import CoreGraphics

/// Content for the "create your first account" onboarding step.
struct OnboardingAccountUIModel: Equatable {
  let stepLabel: String
  let progress: CGFloat
  let title: String
  let subtitle: String

  let nameFieldLabel: String
  let nameFieldPlaceholder: String
  let balanceFieldLabel: String
  let balanceFieldPlaceholder: String
  let currencyGroupLabel: String
  let currencyCodes: [String]

  let primaryButtonTitle: String

  // MARK: - Dummy defaults pre-filled into the form

  let defaultName: String
  let defaultBalance: String
  let defaultCurrencyCode: String
}
