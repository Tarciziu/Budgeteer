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
class CreateTransactionsEndpoint: Endpoint {
  // MARK: - Endpoint Properties

  var id: EndpointPath

  // MARK: - Private Properties

  private let modelContext: ModelContext

  // MARK: - Init

  init(id: EndpointPath, modelContext: ModelContext) {
    self.id = id
    self.modelContext = modelContext
  }

  // MARK: - Endpoint Methods

  func executeRequest<R>(
    requestModel: Request
  ) async throws -> Result<[R]?, DataSourceError> where R: DataSourceModel {
    guard let model = requestModel.body as? TransactionCreationRequestDTO else {
      return .failure(DataSourceError.invalidRequest)
    }

    let transactionModel = TransactionModel(
      title: model.title,
      information: model.information,
      amount: model.amount,
      transactionDate: model.transactionDate,
    )

    let helper = DataSourceHelper.shared
    guard let modelId = helper.map(id: transactionModel.id) else {
      return .failure(.internalInconsistency)
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

    return .success(newTransactions)
  }
}
