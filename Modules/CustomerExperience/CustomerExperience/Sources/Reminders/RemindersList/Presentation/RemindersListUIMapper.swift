//
//  RemindersListUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation

struct RemindersListUIMapper {
  // MARK: - Internal Methods

  func map() -> RemindersListUIModel {
    RemindersListUIModel(
      noteLabel: "Note",
      deleteLabel: "Delete",
      editLabel: "Edit",
      pendingRemindersSection: .init(
        title: "Pending Reminders",
        reminders: [
          .init(
            title: "Pay Monthly Rent",
            caption: "Due on October 26, 2024",
            performance: .init(label: "+$800.00", type: .positive),
            note: "Do not forget"
          ),
          .init(
            title: "Submit Project Report",
            caption: "Due on November 10, 2024",
            performance: .init(label: "+$450.00", type: .positive),
            note: nil
          ),
          .init(
            title: "Call Doctor Appointment",
            caption: "Due on December 1, 2024",
            performance: .init(label: "+$100.00", type: .positive),
            note: "Reminder"
          ),
          .init(
            title: "Buy Weekly Groceries",
            caption: "Due on December 15, 2024",
            performance: .init(label: "+$600.00", type: .positive),
            note: nil
          )
        ]
      ),
      expiredReminderSection: .init(
        title: "Expired Reminders", reminders: [
          .init(
            title: "Renew Streaming Subscription (Yearly)",
            caption: "Due on January 5, 2025",
            performance: .init(label: "+$1000.00", type: .positive),
            note: "Note 1"
          ),
          .init(
            title: "Buy Weekly Groceries",
            caption: "Due on December 15, 2024",
            performance: .init(label: "+$100.00", type: .positive),
            note: nil
          )
        ]
      )
    )
  }
}
