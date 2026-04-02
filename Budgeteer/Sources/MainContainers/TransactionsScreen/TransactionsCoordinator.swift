//
//  TransactionsCoordinator.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import Combine
import Foundation
import FactoryKit
import BTCoreUI
import BTCustomerExperience

class TransactionsCoordinator {
  // MARK: - Internal Properties

  var cancellables: Set<AnyCancellable> = []
  let navigationController: BTNavigationController
  var transactionsViewModel: TransactionsViewModel?
  var transactionSubscription: AnyCancellable?

  // MARK: - Init

  init(navigationController: BTNavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Internal Methods

  func start() {
    let hostingController = makeFullTransactionsScreen()
    navigationController.viewControllers = [hostingController]
  }

  func openTransactionDetailsScreen(with transactionIdentifier: String?) {
    let controller = makeTransactionDetailsScreen(for: transactionIdentifier)
    let modalNavigationController = BTNavigationController()
    modalNavigationController.viewControllers = [controller]
    modalNavigationController.isModalInPresentation = true
    navigationController.present(modalNavigationController, animated: true)
  }
}
