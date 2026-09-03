//
//  OnboardingSelections.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation

/// Lightweight value object carried by the onboarding coordinator between steps so the
/// success screen can echo back what the user entered.
///
/// - Note: This is presentation-only state. Nothing here is persisted; wiring it to
///   `CreateBudgetPlanUseCase` is deliberately out of scope for the UI flow.
public struct OnboardingSelections: Equatable {
  public var accountName: String
  public var startingBalance: String
  public var currencyCode: String
  public var periodRangeText: String

  public init(
    accountName: String,
    startingBalance: String,
    currencyCode: String,
    periodRangeText: String
  ) {
    self.accountName = accountName
    self.startingBalance = startingBalance
    self.currencyCode = currencyCode
    self.periodRangeText = periodRangeText
  }

  /// Placeholder values used until the user overrides them during the flow.
  public static let placeholder = OnboardingSelections(
    accountName: "Cont principal",
    startingBalance: "3.000",
    currencyCode: "RON",
    periodRangeText: "5 iul – 4 aug (30 zile)"
  )
}
