//
//  LocalNotificationsIdentifierParser.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation

/// Type used to parse the payload of a received notification.
final class LocalNotificationsIdentifierParser {
  // MARK: - Private Properties

  private let reminderPrefix = "reminder:"

  // MARK: - Internal Methods

  func parse(identifier: String?) -> LocalNotificationsDestination {
    guard let identifier else {
      return .unknown
    }
    if identifier.hasPrefix(reminderPrefix) {
      let id = identifier.split(separator: reminderPrefix)
      return .reminder(id: String(id[.zero]))
    }
    return .unknown
  }
}
