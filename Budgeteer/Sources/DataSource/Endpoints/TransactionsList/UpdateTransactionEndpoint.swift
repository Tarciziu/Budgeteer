//
//  UpdateTransactionEndpoint.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 26/04/2026.
//

import Foundation
import BTCore
import SwiftData
import BTCustomerExperience

/// Local implementation of the `UpdateTransaction` endpoint.
final actor UpdateTransactionEndpoint: Endpoint, ModelActor {
  // MARK: - Nested Types

  private enum Constants {
    static let transactionIdentifierHeaderKey = "txId"
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
    guard let transactionIdentifier = requestModel.headers[Constants.transactionIdentifierHeaderKey] else {
      throw DataSourceError.invalidHeaders
    }
    guard let body = requestModel.body as? TransactionCreationRequestDTO else {
      throw DataSourceError.invalidRequest
    }

    let predicate = #Predicate<TransactionModel> { model in
      model.identifier == transactionIdentifier
    }

    var fetchDescriptor = FetchDescriptor<TransactionModel>(predicate: predicate)
    fetchDescriptor.fetchLimit = 1

    let fetchedModel: TransactionModel
    do {
      guard let model = try modelContext.fetch(fetchDescriptor).first else {
        throw DataSourceError.missingData
      }
      fetchedModel = model
    } catch {
      throw DataSourceError.missingData
    }

    fetchedModel.title = body.title
    fetchedModel.information = body.information
    fetchedModel.amount = body.amount
    fetchedModel.transactionDate = body.transactionDate

    do {
      try modelContext.save()
    } catch {
      throw DataSourceError.internalInconsistency
    }

    let transactionDTO = TransactionDTO(
      id: fetchedModel.identifier,
      title: fetchedModel.title,
      information: fetchedModel.information,
      amount: fetchedModel.amount,
      transactionDate: fetchedModel.transactionDate
    )

    return [transactionDTO] as? [R]
  }
}
