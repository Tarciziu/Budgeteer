//
//  CreateBudgetPlanEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTCustomerExperience
import BTCore
import SwiftData

/// Local implementation of the `CreateBudgetPlan` endpoint.
final actor CreateBudgetPlanEndpoint: Endpoint, ModelActor {
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
    guard let body = requestModel.body as? BudgetPlanCreationRequestDTO else {
      throw DataSourceError.invalidDataSource
    }

    let plan = BudgetPlanModel(
      name: body.name,
      openingDate: body.openingDate,
      currencyCode: body.currency,
      periodStartDayRaw: body.periodStartDay.rawValue,
      recurrentBalance: body.recurrentBalance,
      monthlyStartingBalance: body.monthlyBudget.startingBalance,
      monthlyPeriodStartDate: body.monthlyBudget.periodStartDate,
      monthlyPeriodEndDate: body.monthlyBudget.periodEndDate
    )

    modelContext.insert(plan)
    do {
      try modelContext.save()
    } catch {
      throw DataSourceError.internalInconsistency
    }

    return [BudgetPlanDataMapper().map(plan)] as? [R]
  }
}
