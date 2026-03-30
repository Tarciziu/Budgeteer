//
//  ReminderConfigurationViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.01.2026.
//

import Foundation
import BTBusinessCore
import BTCore
import BTCoreUI
import Combine

/// Presenation layer entity responsible for managing the reminder configuration page.
@Observable
public class ReminderConfigurationViewModel {
  // MARK: - Nested Types

  public enum OutputEvent {
    case didCreateReminder
    case didClosePage
  }

  private enum Constants {
    static let oneMinuteInSeconds = TimeInterval(60)
  }

  // MARK: - Public Properties

  public var outputPublisher: AnyPublisher<OutputEvent, Never> {
    outputSubject.eraseToAnyPublisher()
  }

  // MARK: - Computed Properties

  private var isInputValidForReminder: Bool {
    !reminderTitleText.isEmpty
  }

  private var isDateValid: Bool {
    Date.now <= reminderDate.addingTimeInterval(Constants.oneMinuteInSeconds)
  }

  // MARK: - Internal Properties

  var reminderTitleText = String() {
    didSet {
      hasInputError = false
    }
  }

  var reminderDate = Date() {
    didSet {
      haseDateError = false
    }
  }

  var uiModel: ReminderConfigurationUIModel
  var amount = String()
  var currency = String()
  var note = String()

  var hasInputError = false
  var haseDateError = false

  var selectedCurrencyIndex: Int = .zero
  let visualTransformation = NumericalVisualTransformation(formatter: NumberFormatterStore().amountInputFormatter)

  // MARK: - Private Properties

  private let addReminderUseCase: CreateReminderUseCase
  private let mapper = ReminderConfigUIMapper()
  private let currencies: [CurrencyDM] = [.eur, .usd]

  private let outputSubject = PassthroughSubject<OutputEvent, Never>()

  private var inputFieldFormatter: NumberFormatter {
    NumberFormatterStore().amountInputFormatter
  }

  // MARK: - Init

  /// Creates a new `ReminderConfigurationViewModel`.
  /// - Parameter interactor: The interactor used by the feature.
  public init(
    initialReminder: Reminder?,
    addReminderUseCase: CreateReminderUseCase
  ) {
    uiModel = mapper.map(currencies: self.currencies)
    self.addReminderUseCase = addReminderUseCase
    configureInitialState(initialReminder: initialReminder)
  }

  // MARK: - Internal Methods

  func handleCancelButton() {
    outputSubject.send(.didClosePage)
  }

  func handleSaveButton() {
    hasInputError = !isInputValidForReminder
    haseDateError = !isDateValid
    guard !hasInputError && !haseDateError else {
      return
    }

    var performance: ReminderPerformance?
    if let value = inputFieldFormatter.number(from: amount)?.floatValue {
      performance = ReminderPerformance(
        value: value,
        performance: mapper.map(value: value),
        currency: getSelectedCurrency()
      )
    }
    let newReminder = ReminderCreationDM(
      name: reminderTitleText,
      triggerDate: reminderDate,
      performance: performance,
      details: note
    )
    Task.detached {
      try await self.addReminderUseCase.createReminder(newReminder)
      await MainActor.run { [weak self] in
        self?.outputSubject.send(.didCreateReminder)
      }
    }
  }

  // MARK: - Private Methods

  private func configureInitialState(initialReminder: Reminder?) {
    guard let initialReminder else {
      return
    }
    self.reminderTitleText = initialReminder.name
    self.reminderDate = initialReminder.triggerDate
    self.currency = CurrencyMapper().map(currency: initialReminder.performance?.currency ?? .eur)
    self.amount = NumberFormatterStore().amountInputFormatter.string(
      for: initialReminder.performance?.value ?? String()
    ) ?? String()
    self.note = initialReminder.details ?? String()
  }

  private func getSelectedCurrency() -> CurrencyDM {
    currencies[selectedCurrencyIndex]
  }
}
