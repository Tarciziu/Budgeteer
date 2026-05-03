//
//  LocalNotificationEvent.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation

/// Type containing all `additional details` decoded from a local notification with regards to a specific notification type, decoded in a concrete type.
enum LocalNotificationEvent {
  case reminder(id: String)
  case unknown
}
