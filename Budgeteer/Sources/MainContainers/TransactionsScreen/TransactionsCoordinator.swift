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

class TransactionsCoordinator {
  // MARK: - Internal Properties

  var cancellables: Set<AnyCancellable> = []

  // MARK: - Private Properties

  private let navigationController: BTNavigationController

  // MARK: - Init

  init(navigationController: BTNavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Internal Methods

  func start() {
    let hostingController = makeFullTransactionsScreen()
    navigationController.viewControllers = [hostingController]
  }
}
