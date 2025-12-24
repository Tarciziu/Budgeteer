//
//  DefaultRemindersListRepository.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import BTCore
import Foundation

/// Default implementation of `DefaultRemindersListRepository`.
final public class DefaultRemindersListRepository: RemindersListRepository {
  // MARK: - Nested Types

  private enum Constants {
    static let remindersKey = "REMINDERS"
  }

  // MARK: - Private Properties

  private let mapper = RemindersListDataMapper()
  private let userPreferences: UserPreferences

  private let jsonDecoder = JSONDecoder()
  private let jsonEncoder = JSONEncoder()

  // MARK: - Init

  /// Creates a new `DefaultRemindersListRepository`.
  /// - Parameter userPreferences: The data source used to fetch cached information.
  public init(userPreferences: UserPreferences) {
    self.userPreferences = userPreferences
  }

  // MARK: - RemindersListRepository Methods

  public func getReminders() -> [Reminder] {
    let cachedData = userPreferences.read(Data.self, forKey: Constants.remindersKey)
    guard let cachedData else {
      return []
    }

    guard let decodedData = try? jsonDecoder.decode([ReminderDTO].self, from: cachedData) else {
      return []
    }
    return mapper.map(decodedData)
  }

  public func storeReminder(_ reminder: Reminder) {
    var currentList = getReminders()
    currentList.append(reminder)
    store(currentList)
  }

  public func removeReminder(_ reminder: Reminder) {
    var currentList = getReminders()
    currentList.append(reminder)
    store(currentList)
  }

  // MARK: - Private Methods

  private func store(_ reminders: [Reminder]) {
    let dataModels = mapper.map(reminders)
    let data = try? jsonEncoder.encode(dataModels)
    guard let data else {
      return
    }
    userPreferences.write(data, forKey: Constants.remindersKey)
  }
}
