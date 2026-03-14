//
//  TransactionsCoordinator+FactoryMethods.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 03.10.2025.
//

import FactoryKit
import BTCoreUI
import BTCustomerExperience

extension TransactionsCoordinator {
  func makeFullTransactionsScreen() -> BTHostingController {
    let viewModel = TransactionsViewModel(
      interactor: Container.shared.transactionsInteractor(),
      configuration: TransactionsConfiguration(type: .expanded)
    )

    viewModel.eventPublisher
      .sink { [weak self] event in
        switch event {
        case let .didTapTransaction(transactionIdentifier):
          self?.openTransactionScreen(with: transactionIdentifier)
        case .didTapExpand:
          // TODO: Handle expand action if needed.
          break
        @unknown default:
          assertionFailure("Unknown event received in TransactionsCoordinator")
        }
      }
      .store(in: &cancellables)

    let transactionsScreen = TransactionsScreen(viewModel: viewModel)
    let hostingController = BTHostingController(containedView: transactionsScreen)

    return hostingController
  }

  func makeTransactionScreen(for transactionIdentifier: String?) -> BTHostingController {
    let screen = TransactionScreen()
    let hostingController = BTHostingController(containedView: screen)
    return hostingController
  }
}
