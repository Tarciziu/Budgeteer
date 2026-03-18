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

/// Implementation of the `GetTransactions` endpoint
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
      transactionDate: model.transactionDate,
    )

    let helper = DataSourceHelper.shared
    guard let modelId = helper.map(id: transactionModel.id) else {
      throw DataSourceError.internalInconsistency
    }

    modelContext.insert(transactionModel)
    try modelContext.save()

    let transactionDTO = TransactionDTO(
      id: modelId,
      title: transactionModel.title,
      amount: transactionModel.amount,
      transactionDate: transactionModel.transactionDate
    )

    let newTransactions: [R]? = [transactionDTO] as? [R]

    return newTransactions
  }
}
