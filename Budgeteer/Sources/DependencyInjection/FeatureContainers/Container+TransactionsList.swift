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

  var getTransactionsUseCase: Factory<GetTransactionsUseCase> {
    self { DefaultGetTransactionsUseCase(repository: self.transactionsRepository()) }.shared
  }

  var createTransactionUseCase: Factory<CreateTransactionUseCase> {
    self { DefaultCreateTransactionUseCase(repository: self.transactionsRepository()) }.shared
  }

  var removeTransactionUseCase: Factory<RemoveTransactionUseCase> {
    self { DefaultRemoveTransactionUseCase(repository: self.transactionsRepository()) }.shared
  }

  var updateTransactionUseCase: Factory<UpdateTransactionUseCase> {
    self { DefaultUpdateTransactionUseCase(repository: self.transactionsRepository()) }.shared
  }

  var getTransactionUseCase: Factory<GetTransactionUseCase> {
    self { DefaultGetTransactionUseCase(repository: self.transactionsRepository()) }.shared
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
      makeGetTransactionEndpoint(),
      makeCreateTransactionEndpoint(),
      makeDeleteTransactionEndpoint(),
      makeUpdateTransactionEndpoint()
    ]

    let filteredEndpoints = endpoints.compactMap { $0 }
    let dataSource = LocalDataSource(endpoints: filteredEndpoints)
    return dataSource
  }

  private func makeGetTransactionsEndpoint() -> GetTransactionsEndpoint? {
    GetTransactionsEndpoint(
      id: TransactionsEndpointsID.getTransactions.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeGetTransactionEndpoint() -> GetTransactionEndpoint? {
    GetTransactionEndpoint(
      id: TransactionsEndpointsID.getTransaction.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeCreateTransactionEndpoint() -> CreateTransactionsEndpoint? {
    CreateTransactionsEndpoint(
      id: TransactionsEndpointsID.createTransaction.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeDeleteTransactionEndpoint() -> DeleteTransactionsEndpoint? {
    DeleteTransactionsEndpoint(
      id: TransactionsEndpointsID.deleteTransaction.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeUpdateTransactionEndpoint() -> UpdateTransactionEndpoint? {
    UpdateTransactionEndpoint(
      id: TransactionsEndpointsID.updateTransaction.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }
}
