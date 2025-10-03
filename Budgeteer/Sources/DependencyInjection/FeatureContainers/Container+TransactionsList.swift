//
//  Container+TransactionsList.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 03.10.2025.
//

import FactoryKit
import BTCustomerExperience

extension Container {
  // MARK: - Transactions List entities

  var transactionsInteractor: Factory<TransactionsInteractor> {
    self { DefaultTransactionsInteractor(transactionsRepository: self.transactionsRepository()) }.shared
  }

  private var transactionsRepository: Factory<TransactionsRepository> {
    self { DefaultTransactionsRepository() }.shared
  }
}
