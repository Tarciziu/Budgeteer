//
//  OnboardingState.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import FactoryKit
import BTCore

/// Persists whether the user has already been through the onboarding flow.
protocol OnboardingState {
  /// `true` once the user has completed (or skipped past) onboarding at least once.
  var hasCompletedOnboarding: Bool { get }

  /// Marks onboarding as completed so subsequent launches go straight to the main app.
  func markOnboardingCompleted()
}

/// Default `OnboardingState` backed by ``UserPreferences`` (a `UserDefaults` wrapper).
struct DefaultOnboardingState: OnboardingState {
  // MARK: - Nested Types

  private enum Constants {
    static let completedKey = "onboarding.completed"
  }

  // MARK: - Private Properties

  private let userPreferences: UserPreferences

  // MARK: - Init

  init(userPreferences: UserPreferences = Container.shared.userPreferences()) {
    self.userPreferences = userPreferences
  }

  // MARK: - OnboardingState

  var hasCompletedOnboarding: Bool {
    userPreferences.bool(forKey: Constants.completedKey)
  }

  func markOnboardingCompleted() {
    userPreferences.write(true, forKey: Constants.completedKey)
  }
}
