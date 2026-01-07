//
//  ReminderConfigUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 06.01.2026.
//

import Foundation

struct ReminderConfigUIMapper {
  func map() -> ReminderConfigurationUIModel {
    ReminderConfigurationUIModel(
      reminderTitleLabel: "Reminder Name",
      reminderTitlePlaceholder: "Enter a name for your reminder",
      reminderDateLabel: "Due Date",
      reminderDatePlaceholder: "Select a due date",
      reminderAmountLabel: "Amount & Currency",
      noteLabel: "Note (Optional)",
      notePlaceholder: "Add any additional notes about this reminder",
      saveButtonTitle: "Save",
      cancelButtonTitle: "Cancel"
    )
  }
}
