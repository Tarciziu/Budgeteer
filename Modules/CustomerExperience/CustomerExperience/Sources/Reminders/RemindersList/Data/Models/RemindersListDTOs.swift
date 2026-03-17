//
//  RemindersDTOs.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.11.2025.
//

import Foundation
import BTCore

public struct ReminderDTO: DataSourceModel {
  public let id: String
  public let name: String
  public let date: Date
  public let performance: ReminderPerformanceDTO?
  public let details: String?

  /// Creates a new `ReminderDTO`.
  /// - Parameters:
  ///   - id: Unique identifier of the object.
  ///   - name: Name of the reminder.
  ///   - date: Due date for the reminder.
  ///   - performance: Optional element describing financial information about the reminder.
  ///   - details: Additional mentions in the reminder.
  public init(
    id: String,
    name: String,
    date: Date,
    performance: ReminderPerformanceDTO?,
    details: String?
  ) {
    self.id = id
    self.name = name
    self.date = date
    self.performance = performance
    self.details = details
  }
}
