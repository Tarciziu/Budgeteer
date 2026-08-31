//
//  CreateReminderUseCase.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation

/// Protocol encapsulating the busines logic for the `CreateReminder` use case.
public protocol CreateReminderUseCase {
  func createReminder(_ creationDM: ReminderCreationDM) async throws
}

/// Default implementation of the `CreateReminderUseCase`.
final public class DefaultCreateReminderUseCase: CreateReminderUseCase {
  // MARK: - Properties

  private let repository: RemindersRepository
  private let notificationsManager: LocalNotificationsManager

  // MARK: - Init

  /// Creates a new `DefaultCreateReminderUseCase`.
  /// - Parameters:
  ///   - repository: Repository used to persist the reminder.
  ///   - notificationsManager: Manager used to schedule the reminder's local notification.
  public init(repository: RemindersRepository, notificationsManager: LocalNotificationsManager) {
    self.repository = repository
    self.notificationsManager = notificationsManager
  }

  // MARK: - CreateReminderUseCase Methods

  public func createReminder(_ creationDM: ReminderCreationDM) async throws {
    let reminder = try await repository.storeReminder(creationDM)
    await scheduleNotificationIfAuthorized(for: reminder)
  }

  // MARK: - Private Methods

  private func scheduleNotificationIfAuthorized(for reminder: Reminder) async {
    let status = await notificationsManager.getNotificationsAuthorizationStatus()
    guard status == .enabled else { return }

    let triggerComponents = Calendar.current.dateComponents(
      [.year, .month, .day, .hour, .minute],
      from: reminder.triggerDate
    )
    let payload = LocalNotificationPayload(
      identifier: reminder.id,
      title: reminder.name,
      body: reminder.details ?? reminder.name,
      triggerConfig: triggerComponents
    )
    notificationsManager.registerNotification(notification: payload)
  }
}
