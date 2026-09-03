//
//  DefaultOnboardingStateTests.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Testing
import BTCore
import InstantMock

@testable import Budgeteer

struct DefaultOnboardingStateTests {
  @Test("Onboarding starts out incomplete and flips to complete once marked.")
  func test_MarkOnboardingCompleted_PersistsFlag() {
    let preferences = MockedUserPreferences()
    let state = DefaultOnboardingState(userPreferences: preferences)

    preferences.expect().call(
      preferences.write(Arg.eq(true), forKey: Arg.eq("onboarding.completed"))
    )

    state.markOnboardingCompleted()

    preferences.verify()
  }
}

// MARK: - Test Doubles

private final class MockedUserPreferences: Mock, UserPreferences {
  private var storage: [String: Any] = [:]

  func write<T>(_ value: T, forKey key: String) {
    super.call(value, key)
  }

  func read<T>(_: T.Type, forKey key: String) -> T? {
    super.call(T.self, key)
  }

  func bool(forKey key: String) -> Bool {
    return super.call(key) as? Bool ?? false
  }

  func doesExist(forKey key: String) -> Bool {
    super.call(key) as? Bool ?? false
  }

  func wipe() {
    storage.removeAll()
  }
}
