//
//  RemindersDomainModels.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.11.2025.
//

import Foundation

/// Type describing a unique identifier for a reminder.
public typealias ReminderID = String

/// Domain model representing a user configured reminder.
public struct Reminder: Equatable {
  /// Unique identifier for the reminder.
  public let id: ReminderID
  /// Title for the reminder used to identify it's purpose.
  public let name: String
  /// Date at which the reminder should be triggered in the future.
  public let triggerDate: Date
  /// Additional value attached to a reminder.
  public let performance: ReminderPerformance?
  /// Optional additional details which can be mentioned for a reminder.
  public let details: String?

  /// Creates a new `Reminder`.
  /// - Parameters:
  ///   - id: Unique identifier of the reminder.
  ///   - name: The name of the reminder.
  ///   - triggerDate: The date at which the remidnder should be triggered.
  ///   - performance: The monetary value attached to the reminder.
  ///   - details: Additional details speciifed by the user with regards to the reminder.
  public init(
    id: String,
    name: String,
    triggerDate: Date,
    performance: ReminderPerformance?,
    details: String?
  ) {
    self.id = id
    self.name = name
    self.triggerDate = triggerDate
    self.performance = performance
    self.details = details
  }
}

/// Creates a new performance configuration for a reminder.
public struct ReminderPerformance: Equatable {
  /// Finanical value attached to a reminder.
  public let value: Float
  /// Performance indicating the finanicla state for a reminder.
  public let performance: Performance
  /// Currency in which the reminder is done.
  public let currency: CurrencyDM

  /// Creates a new `ReminderPerformance`.
  /// - Parameters:
  ///   - value: The value configured for the reminder.
  ///   - performance: Performance indicating the trend of the reminder.
  ///   - currency: Currency in whcih the reminder was stored.
  public init(value: Float, performance: Performance, currency: CurrencyDM) {
    self.value = value
    self.performance = performance
    self.currency = currency
  }
}

/// Type encapsulating all properties necessary to create a reminder.
public struct ReminderCreationDM: Equatable {
  /// The selected name of the reminder by the user.
  public let name: String
  /// Future date at which the reminder will be triggered.
  public let triggerDate: Date
  /// Additional value attached to a reminder.
  public let performance: ReminderPerformance?
  /// Optional additional details which can be mentioned for a reminder.
  public let details: String?

  /// Creates a new `ReminderCreationDM`.
  /// - Parameters:
  ///   - name: selected name of the reminder by the user.
  ///   - triggerDate: date at which the reminder will be triggered.
  ///   - performance: Additional value attached to a reminder.
  ///   - details: Optional additional details which can be mentioned for a reminder.
  public init(
    name: String,
    triggerDate: Date,
    performance: ReminderPerformance?,
    details: String?
  ) {
    self.name = name
    self.triggerDate = triggerDate
    self.performance = performance
    self.details = details
  }
}
