//
//  ReminderConfigUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.01.2026.
//

import Foundation
import BTBusinessCore
import BTCore

struct ReminderConfigUIMapper {
  // MARK: - Static Content

  private enum LocalizedContent {
    static let titleLabel = Strings.CustomerExperience.singular("reminderConfig.titleLabel")
    static let cancelButtonLabel = Strings.CustomerExperience.singular("generalStrings.cancel")
    static let reminderNameError = Strings.CustomerExperience.singular("reminderConfig.errorLabelText")
    static let amountLabel = Strings.CustomerExperience.singular("reminderConfig.amountLabel")
    static let dateLabel = Strings.CustomerExperience.singular("reminderConfig.dateLabel")
    static let noteLabel = Strings.CustomerExperience.singular("reminderConfig.noteLabel")
    static let notePlaceholder = Strings.CustomerExperience.singular("reminderConfig.notePlaceholder")
    static let titlePlaceholder = Strings.CustomerExperience.singular("reminderConfig.titlePlaceholder")
    static let saveButtonLabel = Strings.CustomerExperience.singular("generalStrings.save")
    static let dateError = Strings.CustomerExperience.singular("reminderConfig.dateError")
  }

  // MARK: - Internal Methods

  func map(currencies: [CurrencyDM]) -> ReminderConfigurationUIModel {
    ReminderConfigurationUIModel(
      reminderTitleLabel: LocalizedContent.titleLabel,
      reminderTitlePlaceholder: LocalizedContent.titlePlaceholder,
      nameErrorText: LocalizedContent.reminderNameError,
      dateErrorText: LocalizedContent.dateError,
      reminderDateLabel: LocalizedContent.dateLabel,
      reminderAmountLabel: LocalizedContent.amountLabel,
      noteLabel: LocalizedContent.noteLabel,
      notePlaceholder: LocalizedContent.notePlaceholder,
      saveButtonTitle: LocalizedContent.saveButtonLabel,
      cancelButtonTitle: LocalizedContent.cancelButtonLabel,
      availableCurrencties: currencies.map(CurrencyMapper().map(currency:))
    )
  }

  func map(value: Float) -> Performance {
    guard value != .zero else {
      return .neutral
    }
    return value > .zero ? .positive : .negative
  }
}
