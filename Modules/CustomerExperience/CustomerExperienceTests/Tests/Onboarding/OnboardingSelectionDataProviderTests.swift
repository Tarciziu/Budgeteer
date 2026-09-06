//
//  OnboardingSelectionDataProviderTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import Testing
import BTBusinessCore

@testable import BTCustomerExperience

struct OnboardingSelectionDataProviderTests {
  // MARK: - Constants

  private enum Constants {
    static var calendar: Calendar {
      var calendar = Calendar(identifier: .gregorian)
      calendar.timeZone = .gmt
      return calendar
    }

    /// The user-picked start date: 15 Nov 2023 — the period then runs to 14 Dec.
    static var startDate: Date {
      calendar.date(from: DateComponents(year: 2023, month: 11, day: 15)) ?? .distantPast
    }

    static var expectedEnd: Date {
      calendar.date(from: DateComponents(year: 2023, month: 12, day: 14)) ?? .distantPast
    }
  }

  // MARK: - build()

  @Test("Setters + the picked start date feed build(), which assembles the domain model.")
  func test_Build_AssemblesCreationDM() {
    let provider = OnboardingSelectionDataProvider()
    provider.setAccountName("Holiday fund")
    provider.setStartingBalance(2500)
    provider.setCurrency(.eur)

    let creationDM = provider.build(startDate: Constants.startDate, calendar: Constants.calendar)

    #expect(creationDM.name == "Holiday fund")
    #expect(creationDM.currency == .eur)
    #expect(creationDM.recurrentBalance == 2500)
    #expect(creationDM.periodStartDay == .day15)
    #expect(creationDM.openingDate == Constants.startDate)
    #expect(creationDM.monthlyBudget.startingBalance == 2500)
    #expect(creationDM.monthlyBudget.currentBalance == 2500)
    #expect(creationDM.monthlyBudget.periodStartDate == Constants.startDate)
    #expect(creationDM.monthlyBudget.periodEndDate == Constants.expectedEnd)
  }

  @Test("build() uses the seeded onboarding defaults when no setters are called.")
  func test_Build_UsesSeededDefaults() {
    let creationDM = OnboardingSelectionDataProvider()
      .build(startDate: Constants.startDate, calendar: Constants.calendar)

    #expect(creationDM.name == "Cont principal")
    #expect(creationDM.currency == .ron)
    #expect(creationDM.recurrentBalance == 3000)
  }
}
