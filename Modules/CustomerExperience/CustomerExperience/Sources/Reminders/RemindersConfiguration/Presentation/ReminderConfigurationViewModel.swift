//
//  ReminderConfigurationViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.01.2026.
//

import Foundation
import BTBusinessCore

/// Presenation layer entity responsible for managing the reminder configuration page.
@Observable
public class ReminderConfigurationViewModel {
  // MARK: - Private Properties

  var uiModel: ReminderConfigurationUIModel
  var reminderTitleText = String()
  var reminderDate = Date()
  var amount = String()
  var note = String()

  private let interactor: RemindersInteractor
  private let mapper = ReminderConfigUIMapper()

  // MARK: - Init

  /// Creates a new `ReminderConfigurationViewModel`.
  /// - Parameter interactor: The interactor used by the feature.
  public init(interactor: RemindersInteractor) {
    self.interactor = interactor
    uiModel = mapper.map()
  }

  // MARK: - Internal Methods

  func handleCancelButton() {
  }

  func handleSaveButton() {
  }
}
