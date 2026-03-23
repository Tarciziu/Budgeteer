//
//  RemindersListUIModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation
import BTCore

struct RemindersListUIModel {
  let staticContent: StaticContent
  let loadingContent: LoadableContent<LoadingContent, String>
}

extension RemindersListUIModel {
  struct LoadingContent {
    let pendingRemindersSection: RemindersSection
    let expiredReminderSection: RemindersSection
  }
}

extension RemindersListUIModel {
  struct StaticContent {
    let noteLabel: String
    let deleteLabel: String
    let editLabel: String
  }
}

extension RemindersListUIModel {
  enum PerformanceType: Equatable {
    case positive
    case negative
    case neutral
  }

  struct Performance: Equatable {
    let label: String
    let type: PerformanceType
  }

  struct ReminderUIModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let caption: String
    let performance: Performance?
    let note: String?
  }

  struct RemindersSection {
    let title: String
    let reminders: [ReminderUIModel]
  }
}
