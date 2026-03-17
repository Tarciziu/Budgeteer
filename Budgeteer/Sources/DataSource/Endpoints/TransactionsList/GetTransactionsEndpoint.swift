//
//  GetTransactionsEndpoint.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation
import BTCore
import SwiftData
import BTCustomerExperience

/// Implementation of the `GetTransactions` endpoint
class GetTransactionsEndpoint: Endpoint {
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
    // Note: - This can be improved by passing the order and date sorting information as configuration in the
    // request headers.
    var descriptor = FetchDescriptor<TransactionModel>()
    descriptor.sortBy = [SortDescriptor(\TransactionModel.transactionDate, order: .reverse)]

    do {
      let models = try modelContext.fetch(descriptor)
      let transactionsDTOs = models.compactMap { [weak self] model in
        self?.map(transacitonModel: model, id: model.id)
      }
      let transformedModels = transactionsDTOs as? [R]
      guard let transformedModels else {
        return .failure(DataSourceError.internalInconsistency)
      }
      return .success(transformedModels)
    } catch {
      return .failure(DataSourceError.invalidDataSource)
    }
  }

  // MARK: - Private Methods

  private func map(transacitonModel: TransactionModel, id: PersistentIdentifier) -> TransactionDTO? {
    guard let id = DataSourceHelper.shared.map(id: id) else {
      return nil
    }
    return TransactionDTO(
      id: id,
      title: transacitonModel.title,
      information: transacitonModel.information,
      amount: transacitonModel.amount,
      transactionDate: transacitonModel.transactionDate
    )
  }
}
