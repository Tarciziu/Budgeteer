//
//  GetBudgetPlansEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTCore
import BTCustomerExperience
import SwiftData

/// Local implementation of the `GetBudgetPlans` endpoint.
final actor GetBudgetPlansEndpoint: Endpoint, ModelActor {
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
    let descriptor = FetchDescriptor<BudgetPlanModel>()
    guard let models = try? modelContext.fetch(descriptor) else {
      throw DataSourceError.invalidRequest
    }

    let dtos = models.map(BudgetPlanDataMapper().map)
    return dtos as? [R]
  }
}
