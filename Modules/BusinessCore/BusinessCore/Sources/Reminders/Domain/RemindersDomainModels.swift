//
//  RemindersDomainModels.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.11.2025.
//

import Foundation

/// Domain model representing a user configured reminder.
public struct Reminder: Equatable, Codable {
  public let name: String
  public let triggerDate: Date
  public let performance: ReminderPerformance?
  public let details: String?

  /// Creates a new `Reminder`.
  /// - Parameters:
  ///   - name: The name of the reminder.
  ///   - triggerDate: The date at which the remidnder should be triggered.
  ///   - performance: The monetary value attached to the reminder.
  ///   - details: Additional details speciifed by the user with regards to the reminder.
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

/// Creates a new performance configuration for a reminder.
public struct ReminderPerformance: Equatable, Codable {
  public let value: Float
  public let performance: Performance
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
