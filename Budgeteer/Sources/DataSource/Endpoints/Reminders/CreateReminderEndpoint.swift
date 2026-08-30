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

    guard let id = DataSourceHelper.shared.map(id: newReminder.persistentModelID) else {
      throw DataSourceError.internalInconsistency
    }

    var performance: ReminderPerformanceDTO?
    if let value = body.performance?.value, let currency = body.performance?.currency {
      performance = ReminderPerformanceDTO(value: value, currency: currency)
    }

    let dto = ReminderDTO(
      id: id,
      name: body.name,
      date: body.date,
      performance: performance,
      details: body.details
    )

    return [dto] as? [R]
  }
}
