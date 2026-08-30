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

/// Implementation of the `GetTransactions` endpoint.
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
    var descriptor = FetchDescriptor<TransactionModel>()
    descriptor.sortBy = [SortDescriptor(\TransactionModel.transactionDate, order: .reverse)]

    do {
      let models = try modelContext.fetch(descriptor)
      let transactionsDTOs = models.map { model in
        TransactionDTO(
          id: model.identifier,
          title: model.title,
          information: model.information,
          amount: model.amount,
          category: TransactionCategoryDTO(rawValue: model.category) ?? .other,
          transactionDate: model.transactionDate
        )
      }
      guard let transformedModels = transactionsDTOs as? [R] else {
        throw DataSourceError.internalInconsistency
      }
      return transformedModels
    } catch {
      throw DataSourceError.invalidDataSource
    }
  }
}
