//
//  RemindersListUIMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation
import BTBusinessCore
import BTCore

struct RemindersListUIMapper {
  // MARK: - Internal Methods

  func map(pendingReminders: [Reminder], expiredReminders: [Reminder]) -> RemindersListUIModel {
    let staticContent = makeStatiContent()
    let pendingRemindersUIModel = pendingReminders.map(map)
    let expiredRemindersUIMOdel = expiredReminders.map(map)

    let pendingRemindersSection = RemindersListUIModel.RemindersSection.init(
      title: "Pending reminders",
      reminders: pendingRemindersUIModel
    )

    let expiredRemindersSection = RemindersListUIModel.RemindersSection.init(
      title: "Expired reminders",
      reminders: expiredRemindersUIMOdel
    )
    return RemindersListUIModel(
      staticContent: staticContent,
      loadingContent: .loaded(
        .init(
          pendingRemindersSection: pendingRemindersSection,
          expiredReminderSection: expiredRemindersSection
        )
      )
    )
  }

  func makeLoadingState() -> RemindersListUIModel {
    RemindersListUIModel(
      staticContent: makeStatiContent(),
      loadingContent: .isLoading(nil)
    )
  }

  // MARK: - Private Methods

  private func map(_ reminder: Reminder) -> RemindersListUIModel.ReminderUIModel {
    let formattedDate = DateFormatterStore().longDateTimeFormatter.string(from: reminder.triggerDate)
    var performanceUIModel: RemindersListUIModel.Performance?
    if let performance = reminder.performance {
      let numberFormatter = NumberFormatterStore().amountInputFormatter
      let formattedValue = numberFormatter.string(from: performance.value as NSNumber) ?? String()
      let formattedCurrency = CurrencyMapper().map(currency: performance.currency)
      let formattedLabel = "\(formattedValue) \(formattedCurrency)"
      performanceUIModel = RemindersListUIModel.Performance(
        label: formattedLabel,
        type: makePerformance(for: performance.value)
      )
    }

    return RemindersListUIModel.ReminderUIModel(
      title: reminder.name,
      caption: formattedDate,
      performance: performanceUIModel,
      note: reminder.details
    )
  }

  private func makeStatiContent() -> RemindersListUIModel.StaticContent {
    return RemindersListUIModel.StaticContent(
      noteLabel: "Note",
      deleteLabel: "Delete",
      editLabel: "Edit"
    )
  }

  private func makePerformance(for value: Float) -> RemindersListUIModel.PerformanceType {
    guard value != .zero else {
      return .neutral
    }
    return value > .zero ? .positive : .negative
  }
}
