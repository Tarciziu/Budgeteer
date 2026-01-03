//
//  ReminderConfigurationViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.01.2026.
//

import Foundation

/// Presenation layer entity responsible for managing the reminder configuration page.
@Observable
public class ReminderConfigurationViewModel {
  // MARK: - Private Properties

  private let interactor: RemindersInteractor

  // MARK: - Init

  /// Creates a new `ReminderConfigurationViewModel`.
  /// - Parameter interactor: The interactor used by the feature.
  public init(interactor: RemindersInteractor) {
    self.interactor = interactor
  }
}
