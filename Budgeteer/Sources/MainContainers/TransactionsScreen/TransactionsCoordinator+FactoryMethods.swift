//
//  TransactionsCoordinator+FactoryMethods.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 03.10.2025.
//

import Foundation
import FactoryKit
import BTCoreUI
import BTCustomerExperience

extension TransactionsCoordinator {
  func makeFullTransactionsScreen() -> BTHostingController {
    let viewModel = TransactionsViewModel(
      getTransactionsUseCase: Container.shared.getTransactionsUseCase(),
      configuration: TransactionsConfiguration(type: .expanded)
    )

    viewModel.eventPublisher
      .sink { [weak self, weak viewModel] event in
        switch event {
        case let .didTapTransaction(transactionIdentifier):
          self?.transactionsViewModel = viewModel
          self?.openTransactionDetailsScreen(with: transactionIdentifier)
        case .didTapExpand:
          // TODO: Handle expand action if needed.
          break
        }
      }
      .store(in: &cancellables)

    let transactionsScreen = TransactionsScreen(viewModel: viewModel)
    let hostingController = BTHostingController(containedView: transactionsScreen)

    return hostingController
  }

  func makeTransactionDetailsScreen(for transactionIdentifier: String?) -> BTHostingController {
    let viewModel = TransactionDetailsViewModel(
      transactionIdentifier: transactionIdentifier,
      createTransactionUseCase: Container.shared.createTransactionUseCase(),
      updateTransactionUseCase: Container.shared.updateTransactionUseCase(),
      getTransactionUseCase: Container.shared.getTransactionUseCase()
    )

    transactionSubscription = viewModel.eventPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] event in
        guard let self else { return }
        switch event {
        case .dismiss: break
        case .successful:
          Task {
            await self.transactionsViewModel?.loadTransactions()
          }
        }
        self.navigationController.dismiss(animated: true)
        self.transactionSubscription?.cancel()
        self.transactionSubscription = nil
      }

    let screen = TransactionDetailsScreen(viewModel: viewModel)
    let hostingController = BTHostingController(containedView: screen)
    return hostingController
  }
}
