//
//  ReminderCreationRequestDTO.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import BTCore

public struct ReminderCreationRequestDTO: DataSourceModel {
  public let name: String
  public let date: Date
  public let performance: ReminderPerformanceDTO?
  public let details: String?

  /// Creates a new `ReminderCreationRequestDTO`.
  /// - Parameters:
  ///   - name: Name of the reminder.
  ///   - date: Due date for the reminder.
  ///   - performance: Optional element describing financial information about the reminder.
  ///   - details: Additional mentions in the reminder.
  public init(name: String, date: Date, performance: ReminderPerformanceDTO?, details: String?) {
    self.name = name
    self.date = date
    self.performance = performance
    self.details = details
  }
}

public struct ReminderPerformanceDTO: DataSourceModel {
  public let value: Float
  public let currency: String

  public init(value: Float, currency: String) {
    self.value = value
    self.currency = currency
  }
}
