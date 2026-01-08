//
//  DeveloperMenuCoordinator+Screens.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 06.01.2026.
//

import BTCoreUI

extension DeveloperMenuCoordinator {
  func makeDeveloperMenuScreen() -> BTHostingController {
    let viewModel = DeveloperMenuViewModel()
    let screen = DeveloperMenu(viewModel: viewModel)

    /// Handle events from the Developer Menu screen.
    viewModel.eventPublisher.sink { [weak self] event in
      switch event {
      case .close:
        self?.handleCloseFlow()
      }
    }
    .store(in: &cancellables)

    /// Create the hosting controller.
    let hostingController = BTHostingController(containedView: screen)
    return hostingController
  }
}
