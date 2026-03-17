//
//  ReminderModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import SwiftData
import BTCore

@Model
class ReminderModel: DataSourceModel {
  var name: String
  var date: Date
  var value: Float?
  var currency: String?
  var details: String?

  init(
    name: String,
    date: Date,
    value: Float?,
    currency: String?,
    details: String? = nil
  ) {
    self.name = name
    self.date = date
    self.value = value
    self.currency = currency
    self.details = details
  }
}
