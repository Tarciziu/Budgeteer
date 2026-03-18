//
//  Container+Reminders.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import FactoryKit
import SwiftData
import BTCore
import BTCustomerExperience
import BTBusinessCore

extension Container {
  var remindersInteractor: Factory<RemindersInteractor> {
    self {
      DefaultRemindersInteractor(repository: self.remindersRepository)
    }
    .shared
  }

  private var remindersRepository: RemindersRepository {
    DefaultRemindersRepository(dataSource: makeRemindersDataSource())
  }

  private func makeRemindersDataSource() -> DataSource {
    let endpoints = [
      makeGetRemindersEndpoint(),
      makeRemoveRemindersEndpoint(),
      makeCreateRemindersEndpoint(),
      makeUpdateRemindersEndpoint()
    ]

    let filteredEndpoints = endpoints.compactMap { $0 }
    return LocalDataSource(endpoints: filteredEndpoints)
  }
}

// MARK: - Endpoints

private extension Container {
  private func makeGetRemindersEndpoint() -> Endpoint {
    return GetReminderEndpoints(
      id: RemindersEndpotsID.getReminders.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeRemoveRemindersEndpoint() -> Endpoint {
    return RemoveReminderEndpoint(
      id: RemindersEndpotsID.deleteReminder.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeCreateRemindersEndpoint() -> Endpoint {
    return GetReminderEndpoints(
      id: RemindersEndpotsID.createReminder.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeUpdateRemindersEndpoint() -> Endpoint? {
    return UpdateReminderEndpoint(
      id: RemindersEndpotsID.updateReminder.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }
}
