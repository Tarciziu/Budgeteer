//
//  ObserveReminderNotificationsUseCase.swift
//  BusinessCore
//
//  Created by Adrian-Zoltan Herczeg on 14.05.2026.
//

import Combine

/// Protocol encapsulating the business logic for observing incoming reminder notifications.
public protocol ObserveReminderNotificationsUseCase {
  /// Emits the identifier of a reminder each time its notification is received by the system.
  var reminderReceivedPublisher: AnyPublisher<ReminderID, Never> { get }
}
