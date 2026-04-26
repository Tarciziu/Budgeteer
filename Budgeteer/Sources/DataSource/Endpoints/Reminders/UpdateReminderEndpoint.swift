//
//  UpdateReminderEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import SwiftData
import BTCore
import BTCustomerExperience

/// Local implementation of the `UpdateReminder` endpoint.
final actor UpdateReminderEndpoint: Endpoint, ModelActor {
  // MARK: - Nested Types

  private enum Constants {
    static let reminderIdentifierKey = "rmId"
    static let fetchLimit = 1
  }

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
    guard let reminderIdHeader = requestModel.headers[Constants.reminderIdentifierKey] else {
      throw DataSourceError.invalidHeaders
    }
    guard let body = requestModel.body as? ReminderCreationRequestDTO else {
      throw DataSourceError.missingData
    }

    guard let reminderId = DataSourceHelper.shared.map(from: reminderIdHeader) else {
      throw DataSourceError.internalInconsistency
    }

    let predicate = Predicate<ReminderModel> { model in
      let modelKeyPath = PredicateExpressions.KeyPath(root: model, keyPath: \.id)
      let queryValue = PredicateExpressions.Value(reminderId)
      return PredicateExpressions.Equal(lhs: modelKeyPath, rhs: queryValue)
    }

    var fetchDescriptor = FetchDescriptor<ReminderModel>(predicate: predicate)
    fetchDescriptor.fetchLimit = Constants.fetchLimit

    guard let fetchedModel = try? modelContext.fetch(fetchDescriptor).first else {
      throw DataSourceError.missingData
    }

    fetchedModel.name = body.name
    fetchedModel.date = body.date
    fetchedModel.details = body.details
    fetchedModel.value = body.performance?.value
    fetchedModel.currency = body.performance?.currency

    do {
      try modelContext.save()
    } catch {
      throw DataSourceError.internalInconsistency
    }

    let transformedModels = [fetchedModel] as? [R]

    return transformedModels
  }
}
