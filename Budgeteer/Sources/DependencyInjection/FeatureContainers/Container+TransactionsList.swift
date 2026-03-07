//
//  Container+TransactionsList.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 03.10.2025.
//

import SwiftData
import FactoryKit
import BTCustomerExperience

extension Container {
  // MARK: - Transactions List entities

  var transactionsInteractor: Factory<TransactionsInteractor> {
    self { DefaultTransactionsInteractor(transactionsRepository: self.transactionsRepository()) }.shared
  }

  private var transactionsRepository: Factory<TransactionsRepository> {
    self {
      /// Define the schema.
      let schema = Schema([TransactionDTO.self])

      /// Configure storage.
      let configuration = ModelConfiguration(schema: schema)

      /// Create the container and context

      let modelContext: ModelContext?
      if let container = try? ModelContainer(for: schema, configurations: configuration) {
        modelContext = ModelContext(container)
      } else {
        modelContext = nil
      }

      return DefaultTransactionsRepository(modelContext: modelContext)
    }
    .shared
  }
}
