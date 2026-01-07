//
//  RemindersListDataMapper.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation
import BTBusinessCore

struct RemindersListDataMapper {
  // MARK: - Private Properties

  private let currencyMapper = CurrencyMapper()

  // MARK: - DTO to DM

  func map(_ remindersDTOs: [ReminderDTO]) -> [Reminder] {
    remindersDTOs.map(map(_:))
  }

  // MARK: - DM to DTO

  func map(_ remindersDMs: [Reminder]) -> [ReminderDTO] {
    remindersDMs.map(map(_:))
  }

  // MARK: - Private methods

  private func map(_ reminder: ReminderDTO) -> Reminder {
    var performanceDM: ReminderPerformance?
    if let performanceDTO = reminder.performance {
      var performance: Performance = .neutral
      if performanceDTO.value > .zero {
        performance = .positive
      } else if performanceDTO.value < .zero {
        performance = .nevative
      }

      performanceDM = ReminderPerformance(
        value: performanceDTO.value,
        performance: performance,
        currency: currencyMapper.map(currency: performanceDTO.currency) ?? CurrencyDM.defaultCurrency
      )
    }

    return Reminder(
      name: reminder.name,
      triggerDate: reminder.date,
      performance: performanceDM,
      details: reminder.details
    )
  }

  private func map(_ reminder: Reminder) -> ReminderDTO {
    var performanceDTO: ReminderPerformanceDTO?
    if let performanceDM = reminder.performance {
      performanceDTO = ReminderPerformanceDTO(
        value: performanceDM.value,
        currency: currencyMapper.map(currency: performanceDM.currency)
      )
    }
    return ReminderDTO(
      name: reminder.name,
      date: reminder.triggerDate,
      performance: performanceDTO,
      details: reminder.details
    )
  }
}
