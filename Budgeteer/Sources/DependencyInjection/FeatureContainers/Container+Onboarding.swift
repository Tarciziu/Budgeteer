//
//  Container+Onboarding.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import FactoryKit

extension Container {
  var onboardingState: Factory<OnboardingState> {
    self { DefaultOnboardingState() }.shared
  }
}
