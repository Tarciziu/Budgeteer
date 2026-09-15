//
//  OnboardingSelectionDataProvider.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTBusinessCore

/// Accumulates the values entered across the onboarding steps and assembles them into a
/// ``BudgetPlanCreationDM`` once the configuration is complete.
///
/// Builder-style: the account step feeds its values through the setters; the budget-period step
/// calls ``build(startDate:calendar:)`` with the date the user picked to obtain the domain model to
/// persist.
public final class OnboardingSelectionDataProvider {
  // MARK: - Budget Plan Properties

  private var accountName: String
  private var startingBalance: Decimal
  private var currency: CurrencyDM

  // MARK: - Init

  /// Creates a new provider seeded with the onboarding dummy defaults.
  public init(
    accountName: String = "Cont principal",
    startingBalance: Decimal = 3_000,
    currency: CurrencyDM = .ron
  ) {
    self.accountName = accountName
    self.startingBalance = startingBalance
    self.currency = currency
  }

  // MARK: - Getters

  public func getAccountName() -> String { accountName }
  public func getStartingBalance() -> Decimal { startingBalance }
  public func getCurrency() -> CurrencyDM { currency }

  // MARK: - Setters

  public func setAccountName(_ value: String) { accountName = value }
  public func setStartingBalance(_ value: Decimal) { startingBalance = value }
  public func setCurrency(_ value: CurrencyDM) { currency = value }

  // MARK: - Build

  /// Assembles the accumulated values into a ``BudgetPlanCreationDM``.
  ///
  /// - Parameters:
  ///   - startDate: The budget's first day, as picked on the budget-period step.
  ///   - calendar: Calendar used for the period math.
  ///
  /// The budget runs for a single monthly period starting on `startDate`.
  public func build(startDate: Date, calendar: Calendar = .current) -> BudgetPlanCreationDM {
    let endDate = OnboardingBudgetPeriodHelper.endDate(from: startDate, calendar: calendar)
    let dayOfMonth = calendar.component(.day, from: startDate)

    let monthlyBudget = MonthlyBudgetCreationDM(
      startingBalance: startingBalance,
      currentBalance: startingBalance,
      periodStartDate: startDate,
      periodEndDate: endDate
    )

    return BudgetPlanCreationDM(
      name: accountName,
      openingDate: startDate,
      currency: currency,
      periodStartDay: .from(dayOfMonth: dayOfMonth),
      recurrentBalance: startingBalance,
      monthlyBudget: monthlyBudget
    )
  }
}
