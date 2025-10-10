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
      .sink { event in
        switch event {
        case .didTapTransaction(let transactionIdentifier):
          // TODO: Open transaction details screen.
          // Will be implemented in a future task.
          break
        case .didTapExpand:
          // TODO: Handle expand action if needed.
          break
        @unknown default:
          assertionFailure("Unknown event received in TransactionsCoordinator")
        }
      }
      .store(in: &cancellables)

    let navigationBarConfiguration = NavigationBarConfiguration(
      title: "Transactions Screen"
    )
    let transactionsScreen = TransactionsScreen(config: navigationBarConfiguration, viewModel: viewModel)
    let hostingController = BTHostingController(containedView: transactionsScreen)

    return hostingController
  }
}
