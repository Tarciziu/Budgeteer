//
//  OnboardingBudgetPeriodUIModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import CoreGraphics

/// Content for the "choose your budget period" onboarding step.
struct OnboardingBudgetPeriodUIModel: Equatable {
  let stepLabel: String
  let progress: CGFloat
  let title: String
  let subtitle: String

  let startDateLabel: String
  /// Dummy pre-selected start date, already formatted for display.
  let startDateText: String

  let previewCardLabel: String
  let previewRangeText: String
  let previewCaption: String

  let primaryButtonTitle: String
}
