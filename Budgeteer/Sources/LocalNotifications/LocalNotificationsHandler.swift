//
//  LocalNotificationsHandler.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation
import UserNotifications
import Combine

/// Main entity responsible for handling notifications received by the app.
final class LocalNotificationsHandler: NSObject, UNUserNotificationCenterDelegate {
  // MARK: - Nested Types

  private enum Constants {
    static let identifierKey = "id"
  }

  enum OutputEvent {
    case reminderNotification(id: String)
  }

  // MARK: - Computed Properties

  var outputPublisher: AnyPublisher<LocalNotificationEvent, Never> {
    outputSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let parser = LocalNotificationsIdentifierParser()
  private let outputSubject = PassthroughSubject<LocalNotificationEvent, Never>()

  // MARK: - UNUserNotificationCenterDelegate Methods

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    // This will make so that the notifications are handled silently when the app is in foreground.
    // This method will be triggered, and the block of code will be exectured, but the notification,
    // will not be displayed.
    clearBadge()
    process(notification)
    completionHandler([])
  }

  // MARK: - Private Methods

  private func process(_ notification: UNNotification) {
    let userInfo = notification.request.content.userInfo
    let identifier = userInfo[Constants.identifierKey] as? String
    let parsedId = parser.parse(identifier: identifier)
    switch parsedId {
    case .reminder(let id):
      outputSubject.send(.reminder(id: id))
    case .unknown:
      return
    }
  }

  private func clearBadge() {
    UNUserNotificationCenter.current().setBadgeCount(.zero)
  }
}
