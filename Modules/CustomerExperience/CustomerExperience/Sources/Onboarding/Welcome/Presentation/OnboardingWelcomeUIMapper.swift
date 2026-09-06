//
//  OnboardingWelcomeUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import BTCore

/// Builds the (dummy) content for ``OnboardingWelcomeUIModel``.
struct OnboardingWelcomeUIMapper {
  // MARK: - Internal Methods

  func map() -> OnboardingWelcomeUIModel {
    OnboardingWelcomeUIModel(
      slides: [
        OnboardingWelcomeUIModel.Slide(
          id: 0,
          systemImage: LocalizedStrings.moneySymbol,
          title: LocalizedStrings.slide1Title,
          subtitle: LocalizedStrings.slide1Subtitle,
          ctaTitle: LocalizedStrings.continueCta
        ),
        OnboardingWelcomeUIModel.Slide(
          id: 1,
          systemImage: LocalizedStrings.categoriesSymbol,
          title: LocalizedStrings.slide2Title,
          subtitle: LocalizedStrings.slide2Subtitle,
          ctaTitle: LocalizedStrings.continueCta
        ),
        OnboardingWelcomeUIModel.Slide(
          id: 2,
          systemImage: LocalizedStrings.periodSymbol,
          title: LocalizedStrings.slide3Title,
          subtitle: LocalizedStrings.slide3Subtitle,
          ctaTitle: LocalizedStrings.startCta
        )
      ]
    )
  }
}

private extension OnboardingWelcomeUIMapper {
  enum LocalizedStrings {
    static let moneySymbol = "wallet.bifold"
    static let categoriesSymbol = "chart.pie.fill"
    static let periodSymbol = "calendar"

    static let continueCta = Strings.CustomerExperience.singular("onboarding.cta.continue")
    static let startCta = Strings.CustomerExperience.singular("onboarding.cta.start")

    static let slide1Title = Strings.CustomerExperience.singular("onboarding.welcome.slide1.title")
    static let slide1Subtitle = Strings.CustomerExperience.singular("onboarding.welcome.slide1.subtitle")
    static let slide2Title = Strings.CustomerExperience.singular("onboarding.welcome.slide2.title")
    static let slide2Subtitle = Strings.CustomerExperience.singular("onboarding.welcome.slide2.subtitle")
    static let slide3Title = Strings.CustomerExperience.singular("onboarding.welcome.slide3.title")
    static let slide3Subtitle = Strings.CustomerExperience.singular("onboarding.welcome.slide3.subtitle")
  }
}
