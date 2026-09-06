//
//  OnboardingWelcomeViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Testing
import Combine

@testable import BTCustomerExperience

struct OnboardingWelcomeViewModelTests {
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

  private let viewModel = OnboardingWelcomeViewModel()

  // MARK: - UI Model

  @Test("The welcome view model exposes the expected intro-carousel content.")
  func test_UIModel_MatchesExpectedContent() {
    #expect(viewModel.uiModel == Constants.expectedUIModel)
    #expect(viewModel.selectedSlideIndex == 0)
  }

  @Test("The primary button title follows the visible slide.")
  func test_PrimaryButtonTitle_MatchesSelectedSlide() {
    #expect(viewModel.primaryButtonTitle == viewModel.uiModel.slides[0].ctaTitle)

    viewModel.selectedSlideIndex = 2

    #expect(viewModel.primaryButtonTitle == viewModel.uiModel.slides[2].ctaTitle)
  }

  // MARK: - Behaviour

  @Test("Tapping the primary button on a non-final slide advances to the next slide without emitting an event.")
  func test_HandlePrimaryButtonTap_AdvancesSlide() {
    var receivedEvent = false
    let cancellable = viewModel.eventsPublisher.sink { _ in receivedEvent = true }

    viewModel.handlePrimaryButtonTap()

    #expect(viewModel.selectedSlideIndex == 1)
    #expect(receivedEvent == false)
    cancellable.cancel()
  }

  @Test("Tapping the primary button on the final slide emits `.getStarted`.")
  func test_HandlePrimaryButtonTap_OnLastSlide_EmitsGetStarted() async {
    viewModel.selectedSlideIndex = 2
    var cancellable: AnyCancellable?

    await withCheckedContinuation { continuation in
      cancellable = viewModel.eventsPublisher.sink { event in
        #expect(event == .getStarted)
        continuation.resume()
      }

      viewModel.handlePrimaryButtonTap()
    }

    #expect(viewModel.selectedSlideIndex == 2)
    cancellable?.cancel()
  }
}
