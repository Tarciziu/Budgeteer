//
//  RemindersRepository.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation

/// Main data layer entity used in the reminders list feature.
public protocol RemindersRepository {
  /// Returns the list created reminders, stored in the data base.
  /// - Returns: The list of stored reminders on the device.
  func getReminders() async throws -> [Reminder]

  /// Stores a new reminder.
  /// - Parameter reminder: The new reminder to be cached.
  func storeReminder(_ creationDM: ReminderCreationDM) async throws

  /// Removes a remidner from the list of reminders stored in the data base.
  /// - Parameter id: Unique identifier of the reminder which should be removed.
  func removeReminder(id: ReminderID) async throws
}
