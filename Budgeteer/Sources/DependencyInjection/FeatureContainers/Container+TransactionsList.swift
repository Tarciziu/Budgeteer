//
//  Container+TransactionsList.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 03.10.2025.
//

import SwiftData
import FactoryKit
import BTCustomerExperience
import BTCore

extension Container {
  // MARK: - Transactions List entities

  var transactionsInteractor: Factory<TransactionsInteractor> {
    self { DefaultTransactionsInteractor(transactionsRepository: self.transactionsRepository()) }.shared
  }

  private var transactionsRepository: Factory<TransactionsRepository> {
    self {
      let dataSource = self.swiftDataSource()
      return DefaultTransactionsRepository(dataSource: dataSource)
    }
    .shared
  }

  private var swiftDataSource: Factory<DataSource> {
    self {
      self.makeTransactionsDataSource()
    }
    .shared
  }

  private func makeTransactionsDataSource() -> DataSource {
    let endpoints: [Endpoint?] = [
      makeGetTransactionsEndpoint(),
      makeCreateTransactionEndpoint(),
      makeDeleteTransactionEndpoint()
    ]

    let filteredEndpoints = endpoints.compactMap { $0 }
    let dataSource = LocalDataSource(endpoints: filteredEndpoints)
    return dataSource
  }

  private func makeGetTransactionsEndpoint() -> GetTransactionsEndpoint? {
    // Define the schema.
    let schema = Schema([TransactionModel.self])

    // Configure storage.
    let configuration = ModelConfiguration(schema: schema)

    // Create the container and context
    guard
      let container = try? ModelContainer(for: schema, configurations: configuration) else {
      return nil
    }

    let modelContext = ModelContext(container)

    return GetTransactionsEndpoint(
      id: TransactionsEndpointsID.getTransacitons.rawValue,
      modelContext: modelContext
    )
  }

  private func makeCreateTransactionEndpoint() -> CreateTransactionsEndpoint? {
    // Define the schema.
    let schema = Schema(TransactionModel.self)

    // Configure storage.
    let configuration = ModelConfiguration(schema: schema)

    // Create the container and context
    guard
      let container = try? ModelContainer(for: schema, configurations: configuration) else {
      return nil
    }

    let modelContext = ModelContext(container)

    return CreateTransactionsEndpoint(
      id: TransactionsEndpointsID.createTransaction.rawValue,
      modelContext: modelContext
    )
  }

  private func makeDeleteTransactionEndpoint() -> DeleteTransactionsEndpoint? {
    // Define the schema.
    let schema = Schema(TransactionModel.self)

    // Configure storage.
    let configuration = ModelConfiguration(schema: schema)

    // Create the container and context
    guard
      let container = try? ModelContainer(for: schema, configurations: configuration) else {
      return nil
    }

    let modelContext = ModelContext(container)

    return DeleteTransactionsEndpoint(
      id: TransactionsEndpointsID.deleteTransaction.rawValue,
      modelContext: modelContext
    )
  }
}
