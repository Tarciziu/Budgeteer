//
//  GetReminderEndpoints.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import BTCore
import BTCustomerExperience
import SwiftData

/// Local implementation of the `GetReminder` endpoint.
final actor GetReminderEndpoints: Endpoint, ModelActor {
  // MARK: - Endpoint Properties

  let id: EndpointPath

  // MARK: - ModelActor Properties

  let modelContainer: ModelContainer
  let modelExecutor: any ModelExecutor

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
    let descriptor = FetchDescriptor<ReminderModel>()
    guard let models = try? modelContext.fetch(descriptor) else {
      throw DataSourceError.invalidRequest
    }

    let mappedModels = models.compactMap { model in
      map(model: model, id: DataSourceHelper.shared.map(id: model.persistentModelID))
    }

    let tansformedModels = mappedModels as? [R]
    return tansformedModels
  }

  // MARK: - Private Methods

  private func map(model: ReminderModel, id: String?) -> ReminderDTO? {
    guard let id else {
      return nil
    }
    var performance: ReminderPerformanceDTO?

    if
      let value = model.value,
      let currency = model.currency {
      performance = ReminderPerformanceDTO(value: value, currency: currency)
    }

    return ReminderDTO(
      id: id,
      name: model.name,
      date: model.date,
      performance: performance,
      details: model.details
    )
  }
}
