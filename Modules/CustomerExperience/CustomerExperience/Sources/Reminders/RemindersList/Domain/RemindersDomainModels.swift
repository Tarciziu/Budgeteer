//
//  RemindersDomainModels.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.11.2025.
//

import Foundation

/// Domain model representing a user configured reminder.
public struct Reminder: Equatable, Codable {
  let name: String
  let triggerDate: Date
  let performance: ReminderPerformance?
  let details: String?

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
  let value: Float
  let performance: Performance
  let currency: Currency
}

// TODO: - Move these in a separate module for core business entities

/// Type representing the possbile states of a financial performance.
public enum Performance: Equatable, Codable {
  case positive
  case nevative
  case neutral
}

/// Type mapping supported currencies in the app.
public enum Currency: Equatable, Codable {
  case EUR
  case USD
}
