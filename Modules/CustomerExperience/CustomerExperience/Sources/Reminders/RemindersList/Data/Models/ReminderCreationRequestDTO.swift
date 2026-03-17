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
}

public struct ReminderPerformanceDTO: DataSourceModel {
  public let value: Float
  public let currency: String

  public init(value: Float, currency: String) {
    self.value = value
    self.currency = currency
  }
}
