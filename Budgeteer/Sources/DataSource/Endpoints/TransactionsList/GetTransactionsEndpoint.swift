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
final actor GetTransactionsEndpoint: Endpoint, ModelActor {
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
    // Note: - This can be improved by passing the order and date sorting information as configuration in the
    // request headers.
    var descriptor = FetchDescriptor<TransactionModel>()
    descriptor.sortBy = [SortDescriptor(\TransactionModel.transactionDate, order: .reverse)]

    do {
      let models = (try? modelContext.fetch(descriptor)) ?? []
      let transactionsDTOs = models.compactMap { model in
        map(transacitonModel: model, id: model.id)
      }
      let transformedModels = transactionsDTOs as? [R]
      guard let transformedModels else {
        throw DataSourceError.internalInconsistency
      }
      return transformedModels
    } catch {
      throw DataSourceError.invalidDataSource
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
