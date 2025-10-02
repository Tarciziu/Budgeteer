//
//  ProfilePageUIMapper.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 27.09.2025.
//

import Foundation

struct ProfilePageUIMapper {
  func map() -> ProfilePageUIModel {
    ProfilePageUIModel(
      sections: [
        .init(
          title: "Appearance Settings",
          subtitle: "Customize app theme (Dark/Light mode).",
          type: .appearance,
          links: [
            .init(
              title: "Theme Mode",
              subtitle: "Adjust app's visual theme",
              type: .theming
            )
          ]
        ),
        .init(
          title: "Send Feedback",
          subtitle: "Share your thoughts and suggestions to improve the app.",
          type: .feedback,
          links: [
            .init(
              title: "Submit a Suggestion",
              subtitle: nil,
              type: .suggestion
            )
          ]
        ),
        .init(
          title: "Transaction Reminders",
          subtitle: "Configure notifications for adding new transactions.",
          type: .reminders,
          links: [
            .init(
              title: "Set Monthly Reminder",
              subtitle: nil,
              type: .remindersConfiguration
            )
          ]
        )
      ]
    )
  }
}
