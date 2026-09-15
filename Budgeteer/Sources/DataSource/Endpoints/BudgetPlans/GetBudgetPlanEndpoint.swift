//
//  GetBudgetPlanEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTCore
import BTCustomerExperience
import SwiftData

/// Local implementation of the `GetBudgetPlan` endpoint for fetching a single plan by identifier.
final actor GetBudgetPlanEndpoint: Endpoint, ModelActor {
  // MARK: - Nested Types

  private enum Constants {
    static let budgetPlanIdentifierHeaderKey = "bpId"
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
    guard let identifier = requestModel.headers[Constants.budgetPlanIdentifierHeaderKey] else {
      throw DataSourceError.invalidHeaders
    }

    let predicate = #Predicate<BudgetPlanModel> { model in
      model.identifier == identifier
    }
    var descriptor = FetchDescriptor<BudgetPlanModel>(predicate: predicate)
    descriptor.fetchLimit = Constants.fetchLimit

    guard let model = try? modelContext.fetch(descriptor).first else {
      throw DataSourceError.missingData
    }

    return [BudgetPlanDataMapper().map(model)] as? [R]
  }
}
