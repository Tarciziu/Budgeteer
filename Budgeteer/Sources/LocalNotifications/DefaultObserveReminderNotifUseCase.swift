//
//  DefaultObserveReminderNotifUseCase.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 14.05.2026.
//

import BTBusinessCore
import Combine

/// Default implementation of `ObserveReminderNotificationsUseCase`.
/// Bridges from `LocalNotificationsHandler` events to a domain-level publisher.
final class DefaultObserveReminderNotifUseCase: ObserveReminderNotificationsUseCase {
  // MARK: - ObserveReminderNotificationsUseCase Properties

  var reminderReceivedPublisher: AnyPublisher<ReminderID, Never> {
    notificationsHandler.outputPublisher
      .compactMap { event in
        guard case .reminder(let id) = event else { return nil }
        return id
      }
      .eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let notificationsHandler: LocalNotificationsHandler

  // MARK: - Init

  init(notificationsHandler: LocalNotificationsHandler) {
    self.notificationsHandler = notificationsHandler
  }
}
