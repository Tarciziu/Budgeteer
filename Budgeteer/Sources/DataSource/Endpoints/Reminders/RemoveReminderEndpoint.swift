//
//  RemoveReminderEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import BTCore
import BTCustomerExperience
import SwiftData

/// Local implementation of the `RemoveReminder` endpoint.
final actor RemoveReminderEndpoint: Endpoint, ModelActor {
  // MARK: - Nested type

  private enum Constants {
    static let reminderIdentifierKey = "rmId"
  }

  // MARK: - Endpoint Properties

  let id: EndpointPath

  // MARK: - ModelActor Properties

  let modelExecutor: any ModelExecutor
  let modelContainer: ModelContainer

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
    // - Note: The contract between the endpoint and the repository is curretly not completly defined.
    guard
      let payloadIdentifier = requestModel.headers[Constants.reminderIdentifierKey],
      let reminderIdentifier = DataSourceHelper.shared.map(from: payloadIdentifier) else {
      throw DataSourceError.invalidHeaders
    }

    let predicate = Predicate<ReminderModel> { model in
      let modelKeyPath = PredicateExpressions.KeyPath(root: model, keyPath: \.id)
      let queryValue = PredicateExpressions.Value(reminderIdentifier)
      return PredicateExpressions.Equal(lhs: modelKeyPath, rhs: queryValue)
    }

    try modelContext.delete(model: ReminderModel.self, where: predicate)
    try modelContext.save()

    return nil
  }
}
