//
//  OnboardingAccountViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine

public final class OnboardingAccountViewModel: ObservableObject {
  // MARK: - Nested Types

  /// The values collected on this step. Presentation-only — not persisted.
  public struct Draft: Equatable {
    public let name: String
    public let startingBalance: String
    public let currencyCode: String

    public init(name: String, startingBalance: String, currencyCode: String) {
      self.name = name
      self.startingBalance = startingBalance
      self.currencyCode = currencyCode
    }
  }

  public enum OutputEvent: Equatable {
    case backRequested
    case continueRequested(Draft)
  }

  // MARK: - Published Properties

  @Published var uiModel: OnboardingAccountUIModel
  @Published var name: String
  @Published var startingBalance: String
  @Published var selectedCurrencyIndex: Int

  public var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let mapper = OnboardingAccountUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  // MARK: - Init

  public init() {
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

  func handleBackTap() {
    eventsSubject.send(.backRequested)
  }

  func handleContinueTap() {
    eventsSubject.send(.continueRequested(makeDraft()))
  }

  // MARK: - Private Methods

  private func makeDraft() -> Draft {
    let codes = uiModel.currencyCodes
    let currencyCode = codes.indices.contains(selectedCurrencyIndex)
      ? codes[selectedCurrencyIndex]
      : uiModel.defaultCurrencyCode
    return Draft(
      name: name,
      startingBalance: startingBalance,
      currencyCode: currencyCode
    )
  }
}
