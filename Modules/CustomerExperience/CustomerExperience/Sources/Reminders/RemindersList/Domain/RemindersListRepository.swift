//
//  RemindersListRepository.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation

/// Main data layer entity used in the reminders list feature.
public protocol RemindersListRepository {
  /// Returns the list created reminders, stored on the device.
  /// - Returns: The list of stored reminders on the device.
  func getReminders() -> [Reminder]

  /// Stores a new reminder.
  /// - Parameter reminder: The new reminder to be cached.
  func storeReminder(_ reminder: Reminder)

  /// Removes a remidner from the list of reminders stored on the device.
  /// - Parameter reminder: Reminder which should be removed.
  func removeReminder(_ reminder: Reminder)
}
