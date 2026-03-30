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
  var createReminderUsecase: Factory<CreateReminderUseCase> {
    self {
      DefaultCreateReminderUseCase(repository: self.remindersRepository)
    }
    .shared
  }

  var removeReminderUsecase: Factory<RemoveReminderUseCase> {
    self {
      DefaultRemoveReminderUseCase(repository: self.remindersRepository)
    }
    .shared
  }

  var getRemindersUsecase: Factory<GetRemindersUseCase> {
    self {
      DefaultGetRemindersUseCase(repository: self.remindersRepository)
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

    return LocalDataSource(endpoints: endpoints)
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
    return CreateReminderEndpoint(
      id: RemindersEndpotsID.createReminder.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeUpdateRemindersEndpoint() -> Endpoint {
    return UpdateReminderEndpoint(
      id: RemindersEndpotsID.updateReminder.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }
}
