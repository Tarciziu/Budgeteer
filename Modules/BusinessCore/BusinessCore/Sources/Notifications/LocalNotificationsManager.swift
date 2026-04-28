//
//  LocalNotificationsManager.swift
//  BusinessCore
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation

/// Main entity used to interact with the local notifications system.
public protocol LocalNotificationsManager {
  /// Checks the autorization status for notifications.
  /// - Returns: The autorization status for notifications.
  func getNotificationsAuthorizationStatus() async -> LocalNotificationsAuthorizationStatus

  /// Registers the device for local notifications.
  /// - Returns: Type providing the status of registration for local notifications.
  ///
  /// - Note: The returned result will be either ``Void`` if the registration was succesfull or a ``LocalNotificationsError`` otherwise.
  func registerForLocalNotifications() async -> Result<Void, LocalNotificationsError>

  /// Registers a notification for a future triggering.
  /// - Parameter notification: Payload of the notification.
  func registerNotification(notification: LocalNotificationPayload)
}
