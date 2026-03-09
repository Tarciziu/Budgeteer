//
//  DeleteTransactionEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation
import BTCore
import SwiftData
import BTCustomerExperience

/// Implementation of the `DeleteTransactions` endpoint
class DeleteTransactionsEndpoint: Endpoint {
  // MARK: - Constants

  enum Constants {
    static let transactionIdentifierHeaderKey = "txId"
  }

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
    // - Note: The contract between the endpoint and the repository is curretly not completly defined.
    guard
      let payloadIdentifier = requestModel.headers[Constants.transactionIdentifierHeaderKey],
      let transactionIdentifier = DataSourceHelper.shared.map(from: payloadIdentifier) else {
      return .failure(DataSourceError.invalidHeaders)
    }

    let predicate = Predicate<TransactionModel> { model in
      let modelKeyPath = PredicateExpressions.KeyPath(root: model, keyPath: \.id)
      let queryValue = PredicateExpressions.Value(transactionIdentifier)
      return PredicateExpressions.Equal(lhs: modelKeyPath, rhs: queryValue)
    }

    try modelContext.delete(model: TransactionModel.self, where: predicate)
    try modelContext.save()

    return .success(nil)
  }
}
