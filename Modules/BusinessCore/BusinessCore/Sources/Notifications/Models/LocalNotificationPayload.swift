//
//  LocalNotificationPayload.swift
//  BusinessCore
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation

/// Type describing a unique identifier for a local notification.
public typealias LocalNotificationIdentifier = String

/// The payload of a local notification
public struct LocalNotificationPayload {
  /// The unique identifier of a local notification.
  public let identifier: LocalNotificationIdentifier
  /// The title of the local notification.
  public let title: String
  /// The body of the notification.
  public let body: String
  /// Configuration describing the time of trigering the notification.
  public let triggerConfig: DateComponents
  /// Flag indicating if the notfication is a recurrent one.
  public let isRepeating: Bool

  // MARK: - Init

  /// Creates a new `LocalNotificationPayload`.
  /// - Parameters:
  ///   - identifier: Unique identifier of a local notification.
  ///   - title: The title of the local notification.
  ///   - bodyregisterNotification: The body of the notification.
  ///   - triggerConfig: Configuration describing the time of trigering the notification.
  ///   - isRepeating: Flag indicating if the notfication is a recurrent one.
  public init(
    identifier: LocalNotificationIdentifier,
    title: String,
    body: String,
    triggerConfig: DateComponents,
    isRepeating: Bool = false
  ) {
    self.identifier = identifier
    self.title = title
    self.body = body
    self.triggerConfig = triggerConfig
    self.isRepeating = isRepeating
  }
}
