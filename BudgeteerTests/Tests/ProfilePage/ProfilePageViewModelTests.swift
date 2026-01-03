//
//  ProfilePageViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.01.2026.
//

import Testing
import Combine

@testable import Budgeteer

struct ProfilePageViewModelTests {
  // MARK: - Private Properties

  private let profilePageViewModel = ProfilePageViewModel()

  // MARK: - Tests

  @Test("Tests the response of the view model when a request to navigate to the REMINDERS page is sent.")
  func test_HandleNavigationLinkTap_CorrectHandlingForRemindersNavigationRequest() async {
    // Given
    var cancellable: AnyCancellable?

    // When
    await withCheckedContinuation { continuation in
      cancellable = profilePageViewModel.eventsPublisher.sink { event in
        // Then
        #expect(event == .internalNavigation(destination: .reminders))
        continuation.resume()
      }

      profilePageViewModel.handleNavigationLinkTap(linkType: .remindersConfiguration)
    }
  }

  @Test("Tests the response of the view model when a request to navigate to the SUGGESTIONS page is sent.")
  func test_HandleNavigationLinkTap_CorrectHandlingForSuggestionsNavigationRequest() async {
    // Given
    var cancellable: AnyCancellable?

    // When
    await withCheckedContinuation { continuation in
      cancellable = profilePageViewModel.eventsPublisher.sink { event in
        // Then
        #expect(event == .internalNavigation(destination: .feedback))
        continuation.resume()
      }

      profilePageViewModel.handleNavigationLinkTap(linkType: .suggestion)
    }
  }

  @Test("Tests the response of the view model when a request to navigate to the APPEARANCE page is sent.")
  func test_HandleNavigationLinkTap_CorrectHandlingForAppearanceNavigationRequest() async {
    // Given
    var cancellable: AnyCancellable?

    // When
    await withCheckedContinuation { continuation in
      cancellable = profilePageViewModel.eventsPublisher.sink { event in
        // Then
        #expect(event == .internalNavigation(destination: .themeCustomization))
        continuation.resume()
      }

      profilePageViewModel.handleNavigationLinkTap(linkType: .theming)
    }
  }
}
