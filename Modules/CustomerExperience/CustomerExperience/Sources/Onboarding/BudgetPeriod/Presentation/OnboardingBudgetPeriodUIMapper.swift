//
//  OnboardingBudgetPeriodUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import BTCore

/// Builds the (dummy) content for ``OnboardingBudgetPeriodUIModel``.
struct OnboardingBudgetPeriodUIMapper {
  func map() -> OnboardingBudgetPeriodUIModel {
    OnboardingBudgetPeriodUIModel(
      stepLabel: Constants.stepLabel,
      progress: Constants.progress,
      title: Constants.title,
      subtitle: Constants.subtitle,
      startDateLabel: Constants.startDateLabel,
      startDateText: Constants.startDateText,
      previewCardLabel: Constants.previewCardLabel,
      previewRangeText: Constants.previewRangeText,
      previewCaption: Constants.previewCaption,
      primaryButtonTitle: Constants.primaryButtonTitle
    )
  }
}

private extension OnboardingBudgetPeriodUIMapper {
  enum Constants {
    static let progress: CGFloat = 1.0
    static let startDateText = "5 iulie 2026"
    static let previewRangeText = "5 iulie – 4 august"

    static let stepLabel = Strings.CustomerExperience.singular("onboarding.budgetPeriod.stepLabel")
    static let title = Strings.CustomerExperience.singular("onboarding.budgetPeriod.title")
    static let subtitle = Strings.CustomerExperience.singular("onboarding.budgetPeriod.subtitle")
    static let startDateLabel = Strings.CustomerExperience.singular("onboarding.budgetPeriod.startDate.label")
    static let previewCardLabel = Strings.CustomerExperience.singular("onboarding.budgetPeriod.preview.label")
    static let previewCaption = Strings.CustomerExperience.singular("onboarding.budgetPeriod.preview.caption")
    static let primaryButtonTitle = Strings.CustomerExperience.singular("onboarding.budgetPeriod.cta")
  }
}
