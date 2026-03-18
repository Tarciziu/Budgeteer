//
//  DefaultRemindersInteractor.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation
import BTBusinessCore

/// Default implementation of the `RemindersInteractor`.
final public class DefaultRemindersInteractor: RemindersInteractor {
  // MARK: - Private Properties

  private let repository: RemindersRepository

  // MARK: - Init

  /// Creates a new `DefaultRemindersInteractor`.
  /// - Parameter repository: The data layer entity used for information retrieval.
  public init(repository: RemindersRepository) {
    self.repository = repository
  }

  // MARK: - RemindersInteractor Methods

  public func getReminders() async throws -> [Reminder] {
    try await repository.getReminders()
  }

  public func storeReminder(_ reminder: Reminder) async throws {
    try await repository.storeReminder(reminder)
  }

  public func removeReminder(_ reminder: Reminder) async throws {
    try await repository.removeReminder(reminder)
  }
}
