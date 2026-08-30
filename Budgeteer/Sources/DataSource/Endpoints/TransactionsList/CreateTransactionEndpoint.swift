//
//  CreateTransactionEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation
import BTCore
import SwiftData
import BTCustomerExperience

/// Implementation of the `CreateTransaction` endpoint.
final actor CreateTransactionsEndpoint: Endpoint, ModelActor {
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
    guard let model = requestModel.body as? TransactionCreationRequestDTO else {
      throw DataSourceError.invalidRequest
    }

    let transactionModel = TransactionModel(
      title: model.title,
      information: model.information,
      amount: model.amount,
      category: model.category,
      transactionDate: model.transactionDate
    )

    modelContext.insert(transactionModel)
    try modelContext.save()

    let transactionDTO = TransactionDTO(
      id: transactionModel.identifier,
      title: transactionModel.title,
      information: transactionModel.information,
      amount: transactionModel.amount,
      category: TransactionCategoryDTO(rawValue: transactionModel.category) ?? .other,
      transactionDate: transactionModel.transactionDate
    )

    return [transactionDTO] as? [R]
  }
}
