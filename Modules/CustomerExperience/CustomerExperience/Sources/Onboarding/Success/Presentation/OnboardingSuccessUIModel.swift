//
//  OnboardingSuccessUIModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

/// Content for the final onboarding step: a confirmation summary.
struct OnboardingSuccessUIModel: Equatable {
  let title: String
  let subtitle: String
  let rows: [Row]
  let primaryButtonTitle: String
}

extension OnboardingSuccessUIModel {
  struct Row: Identifiable, Equatable {
    /// The row labels are unique, so the label doubles as a stable identity.
    var id: String { label }
    let label: String
    let value: String
    /// Highlighted rows use the tint color for their value (e.g. the current period).
    let isHighlighted: Bool
  }
}
