//
//  OnboardingWelcomeUIModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation

/// Content for the onboarding welcome carousel (3 intro slides).
struct OnboardingWelcomeUIModel: Equatable {
  let slides: [Slide]
}

extension OnboardingWelcomeUIModel {
  struct Slide: Identifiable, Hashable {
    let id: Int
    let systemImage: String
    let title: String
    let subtitle: String
    /// Label of the primary button while this slide is visible.
    let ctaTitle: String
  }
}
