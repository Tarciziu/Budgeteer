//
//  RemoveReminderUseCase.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation

/// Protocol encapsulating the busines logic for the `RemoveReminder` use case.
public protocol RemoveReminderUseCase {
  func removeReminder(id: ReminderID) async throws
}

/// Default implementation of the `GetRemindersUseCase`.
final public class DefaultRemoveReminderUseCase: RemoveReminderUseCase {
  // MARK: - GetRemindersUseCase Properties

  private let repository: RemindersRepository

  // MARK: - Init

  /// Creates a new `DefaultRemoveReminderUseCase`
  /// - Parameter repository: Repository used in the use case.
  public init(repository: RemindersRepository) {
    self.repository = repository
  }

  // MARK: - RemoveReminderUseCase Methods

  public func removeReminder(id: ReminderID) async throws {
    try await repository.removeReminder(id: id)
  }
}
