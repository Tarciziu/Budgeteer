//
//  CreateReminderUseCase.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

/// Protocol encapsulating the busines logic for the `CreateReminder` use case.
public protocol CreateReminderUseCase {
  func createReminder(_ creationDM: ReminderCreationDM) async throws
}

/// Default implementation of the `GetRemindersUseCase`.
final public class DefaultCreateReminderUseCase: CreateReminderUseCase {
  // MARK: - GetRemindersUseCase Properties

  private let repository: RemindersRepository

  // MARK: - Init

  /// Creates a new `DefaultGetRemindersUseCase`
  /// - Parameter repository: Repository used in the use case.
  public init(repository: RemindersRepository) {
    self.repository = repository
  }

  // MARK: - CreateReminderUseCase Methods

  public func createReminder(_ creationDM: ReminderCreationDM) async throws {
    try await repository.storeReminder(creationDM)
  }
}
