//
//  RemindersDTOs.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.11.2025.
//

import Foundation

struct ReminderDTO: Codable {
  let name: String
  let date: Date
  let performance: ReminderPerformanceDTO?
  let details: String?
}

struct ReminderPerformanceDTO: Codable {
  let value: Float
  let currency: String
}
