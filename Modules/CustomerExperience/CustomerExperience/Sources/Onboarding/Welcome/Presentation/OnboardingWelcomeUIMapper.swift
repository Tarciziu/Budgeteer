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
  func map() -> OnboardingWelcomeUIModel {
    OnboardingWelcomeUIModel(
      slides: [
        OnboardingWelcomeUIModel.Slide(
          id: 0,
          systemImage: Constants.moneySymbol,
          title: Constants.slide1Title,
          subtitle: Constants.slide1Subtitle,
          ctaTitle: Constants.continueCta
        ),
        OnboardingWelcomeUIModel.Slide(
          id: 1,
          systemImage: Constants.categoriesSymbol,
          title: Constants.slide2Title,
          subtitle: Constants.slide2Subtitle,
          ctaTitle: Constants.continueCta
        ),
        OnboardingWelcomeUIModel.Slide(
          id: 2,
          systemImage: Constants.periodSymbol,
          title: Constants.slide3Title,
          subtitle: Constants.slide3Subtitle,
          ctaTitle: Constants.startCta
        )
      ]
    )
  }
}

private extension OnboardingWelcomeUIMapper {
  enum Constants {
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
