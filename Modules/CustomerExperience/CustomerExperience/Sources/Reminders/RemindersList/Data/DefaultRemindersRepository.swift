//
//  DefaultRemindersRepository.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import BTCore
import Foundation
import BTBusinessCore

/// Default implementation of `RemindersRepository`.
final public class DefaultRemindersRepository: RemindersRepository {
  // MARK: - Nested Types

  private enum Constants {
    static let reminderIdKey: String = "rmId"
  }

  // MARK: - Private Properties

  private let mapper = RemindersListDataMapper()
  private let dataSource: DataSource

  // MARK: - Init

  /// Creates a new `DefaultRemindersRepository`.
  /// - Parameter userPreferences: The data source used to fetch cached information.
  public init(dataSource: DataSource) {
    self.dataSource = dataSource
  }

  // MARK: - RemindersRepository Methods

  public func getReminders() async throws -> [Reminder] {
    let request = Request(id: RemindersEndpotsID.getReminders.rawValue)
    let result: [ReminderDTO]? = try await dataSource.executeRequest(request: request)
    return mapper.map(result ?? [])
  }

  @discardableResult
  public func storeReminder(_ reminder: ReminderCreationDM) async throws -> Reminder {
    let requestBody = mapper.map(reminder)
    let requestId = RemindersEndpotsID.createReminder.rawValue
    let request = Request(id: requestId, body: requestBody)
    let result: [ReminderDTO]? = try await dataSource.executeRequest(request: request)
    guard let created = mapper.map(result ?? []).first else {
      throw DataSourceError.internalInconsistency
    }
    return created
  }

  public func removeReminder(id: ReminderID) async throws {
    let headers: [String: String] = [Constants.reminderIdKey: id]
    let request = Request(id: RemindersEndpotsID.deleteReminder.rawValue, requestHeaders: headers)
    let _: [ReminderDTO]? = try await dataSource.executeRequest(request: request)
  }
}
