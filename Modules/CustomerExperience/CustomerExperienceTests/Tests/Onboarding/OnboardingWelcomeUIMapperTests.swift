//
//  OnboardingWelcomeUIMapperTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Testing

@testable import BTCustomerExperience

struct OnboardingWelcomeUIMapperTests {
  // MARK: - Constants

  private enum Constants {
    static let expectedUIModel = OnboardingWelcomeUIModel(
      slides: [
        OnboardingWelcomeUIModel.Slide(
          id: 0,
          systemImage: "wallet.bifold",
          title: "Manage your money, effortlessly",
          subtitle: "Track your spending, see where your money goes and save more — no complicated spreadsheets.",
          ctaTitle: "Continue"
        ),
        OnboardingWelcomeUIModel.Slide(
          id: 1,
          systemImage: "chart.pie.fill",
          title: "See exactly where your money goes",
          subtitle: "Your spending is sorted into categories automatically, "
            + "so you can see at a glance what eats up most of your budget.",
          ctaTitle: "Continue"
        ),
        OnboardingWelcomeUIModel.Slide(
          id: 2,
          systemImage: "calendar",
          title: "Budgets on your schedule, not the calendar's",
          subtitle: "Pick any 30-day window — say 6 June – 5 July — and track your progress the way it works for you.",
          ctaTitle: "Get started"
        )
      ]
    )
  }

  // MARK: - Private Properties

  private let mapper = OnboardingWelcomeUIMapper()

  // MARK: - Tests

  @Test("The welcome mapper produces the expected onboarding carousel content.")
  func test_Map_ProducesExpectedUIModel() {
    #expect(mapper.map() == Constants.expectedUIModel)
  }
}
