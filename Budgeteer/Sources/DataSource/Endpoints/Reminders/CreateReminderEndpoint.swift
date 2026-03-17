//
//  CreateReminderEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import BTCustomerExperience
import BTCore
import SwiftData

/// Local implementation of the `CreateReminder` endpoint.
final actor CreateReminderEndpoint: Endpoint, ModelActor {
  // MARK: - Endpoint Properties

  let id: EndpointPath

  // MARK: - ModelActor Properties

  let modelContainer: ModelContainer
  let modelExecutor: any ModelExecutor

  // MARK: - Init

  init(id: EndpointPath, modelContainer: ModelContainer) {
    self.id = id
    self.modelContainer = modelContainer
    let context = ModelContext(modelContainer)
    self.modelExecutor = DefaultSerialModelExecutor(modelContext: context)
  }

  // MARK: - Endpoint Methods

  func executeRequest<R>(
    requestModel: Request
  ) async throws -> [R]? where R: DataSourceModel {
    guard let body = requestModel.body as? ReminderCreationRequestDTO else {
      throw DataSourceError.invalidDataSource
    }
    let newReminder = ReminderModel(
      name: body.name,
      date: body.date,
      value: body.performance?.value,
      currency: body.performance?.currency,
      details: body.details
    )

    modelContext.insert(newReminder)
    do {
      try modelContext.save()
    } catch {
      throw DataSourceError.internalInconsistency
    }

    return nil
  }
}
