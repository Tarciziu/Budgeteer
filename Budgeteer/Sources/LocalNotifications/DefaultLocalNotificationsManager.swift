//
//  DefaultLocalNotificationsManager.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation
import BTBusinessCore
import UserNotifications

/// Default implementation of the `LocalNotificationsManager`.
final class DefaultLocalNotificationsManager: LocalNotificationsManager {
  // MARK: - Private Properties

  private let notificationCenter = UNUserNotificationCenter.current()
  private let config: Config

  // MARK: - Init

  init(config: Config) {
    self.config = config
  }

  // MARK: - LocalNotificationsManager Methods

  func getNotificationsAuthorizationStatus() async -> LocalNotificationsAuthorizationStatus {
    let settings = await notificationCenter.notificationSettings()
    let authorizationStatus = settings.authorizationStatus
    switch authorizationStatus {
    case .authorized:
      return .enabled
    case .notDetermined:
      return .notRequested
    default:
      return .disabled
    }
  }

  func registerForLocalNotifications() async -> Result<Void, LocalNotificationsError> {
    let requestStatus = try? await notificationCenter.requestAuthorization(options: Self.remindersNotificationsPermissions)
    return requestStatus == true ? .success(()) : .failure(.authorizationFailure)
  }

  func registerNotification(notification: LocalNotificationPayload) {
    let trigger = UNCalendarNotificationTrigger(
      dateMatching: notification.triggerConfig,
      repeats: notification.isRepeating
    )

    let content = UNMutableNotificationContent()
    content.title = notification.title
    content.body = notification.body
    content.sound = .default
    content.threadIdentifier = config.appNotificationsGroupIdentifier

    let request = UNNotificationRequest(identifier: notification.identifier, content: content, trigger: trigger)
    notificationCenter.add(request)
  }
}

extension DefaultLocalNotificationsManager {
  struct Config {
    let appNotificationsGroupIdentifier: String
  }
}

private extension DefaultLocalNotificationsManager {
  static let remindersNotificationsPermissions: UNAuthorizationOptions = [.alert, .sound, .badge]
}
