//
//  GetRemindersUseCase.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

/// Protocol encapsulating the busines logic for the `GetReminders` use case.
public protocol GetRemindersUseCase {
  func getReminders() async throws -> [Reminder]
}

/// Default implementation of the `GetRemindersUseCase`.
final public class DefaultGetRemindersUseCase: GetRemindersUseCase {
  // MARK: - GetRemindersUseCase Properties

  private let repository: RemindersRepository

  // MARK: - Init

  /// Creates a new `DefaultGetRemindersUseCase`
  /// - Parameter repository: Repository used in the use case.
  public init(repository: RemindersRepository) {
    self.repository = repository
  }

  // MARK: - GetRemindersUseCase Methods

  public func getReminders() async throws -> [Reminder] {
    try await repository.getReminders()
  }
}
