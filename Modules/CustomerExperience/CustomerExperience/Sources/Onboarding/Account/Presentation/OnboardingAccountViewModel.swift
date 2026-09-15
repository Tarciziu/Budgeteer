//
//  OnboardingAccountViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine
import BTCore
import BTCoreUI
import BTBusinessCore

/// Presentation layer entiy responsible for the screen in which the user configures the initial depot.
public final class OnboardingAccountViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Type indicating the signals emited by the view model.
  public enum OutputEvent: Equatable {
    /// Signal emited when the user reqeusts to go to the next page and all the validations have passed.
    case continueRequested
  }

  // MARK: - Published Properties

  @Published var uiModel: OnboardingAccountUIModel
  @Published var name: String
  @Published var startingBalance: String {
    didSet { hasBalanceError = false }
  }
  @Published var selectedCurrencyIndex: Int
  @Published var hasBalanceError = false

  public var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Internal Properties

  let visualTransformation = NumericalVisualTransformation(formatter: NumberFormatterStore().amountInputFormatter)

  // MARK: - Private Properties

  private let dataProvider: OnboardingSelectionDataProvider
  private let mapper = OnboardingAccountUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  private var parsedBalance: Decimal? {
    NumberFormatterStore().amountInputFormatter.number(from: startingBalance)?.decimalValue
  }

  private var isBalanceValid: Bool {
    guard let parsedBalance else { return false }
    return parsedBalance > 0
  }

  private var selectedCurrency: CurrencyDM {
    let codes = uiModel.currencyCodes
    let currencyCode = codes.indices.contains(selectedCurrencyIndex)
      ? codes[selectedCurrencyIndex]
      : uiModel.defaultCurrencyCode
    return CurrencyMapper().map(currency: currencyCode) ?? .defaultCurrency
  }

  // MARK: - Init

  /// Creates a new `OnboardingAccountViewModel`.
  /// - Parameter dataProvider: Accumulates the values entered across the onboarding steps; this step
  ///   writes the account name, starting balance and currency onto it.
  public init(dataProvider: OnboardingSelectionDataProvider) {
    self.dataProvider = dataProvider
    let uiModel = mapper.map()
    self.uiModel = uiModel
    self.name = uiModel.defaultName
    self.startingBalance = uiModel.defaultBalance
    self.selectedCurrencyIndex = uiModel.currencyCodes.firstIndex(of: uiModel.defaultCurrencyCode) ?? 0
  }

  // MARK: - Internal Methods

  func selectCurrency(at index: Int) {
    guard uiModel.currencyCodes.indices.contains(index) else { return }
    selectedCurrencyIndex = index
  }

  func handleContinueTap() {
    hasBalanceError = !isBalanceValid
    guard let balance = parsedBalance, balance > 0 else { return }

    dataProvider.setAccountName(name)
    dataProvider.setStartingBalance(balance)
    dataProvider.setCurrency(selectedCurrency)
    eventsSubject.send(.continueRequested)
  }
}
