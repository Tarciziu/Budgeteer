//
//  DeveloperMenuCoordinator+Screens.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 06.01.2026.
//

import SwiftUI
import BTCoreUI

extension DeveloperMenuCoordinator {
  func makeDeveloperMenuScreen() -> BTHostingController {
    let viewModel = DeveloperMenuViewModel()
    let screen = DeveloperMenu(viewModel: viewModel)

    viewModel.eventPublisher.sink { [weak self] event in
      switch event {
      case .close:
        self?.handleCloseFlow()
      case let .navigate(destination):
        self?.navigateFromMenu(to: destination)
      }
    }
    .store(in: &cancellables)

    let hostingController = BTHostingController(containedView: screen)
    return hostingController
  }

  // MARK: - Menu Navigation

  private func navigateFromMenu(to destination: DeveloperMenuViewModel.Destination) {
    switch destination {
    case .componentsLibrary:
      navigateToComponentsLibrary()
    }
  }

  // MARK: - Components Library

  private func navigateToComponentsLibrary() {
    let viewModel = ComponentsLibraryViewModel()
    let screen = ComponentsLibraryScreen(viewModel: viewModel)

    viewModel.eventPublisher.sink { [weak self] event in
      switch event {
      case let .navigate(destination):
        self?.navigateToComponentSample(destination)
      }
    }
    .store(in: &cancellables)

    let hostingController = BTHostingController(containedView: screen)
    navigationController.pushViewController(hostingController, animated: true)
  }

  // MARK: - Component Samples

  private func navigateToComponentSample(_ destination: ComponentsLibraryViewModel.ComponentDestination) {
    let screen = makeComponentSampleScreen(for: destination)
    let hostingController = BTHostingController(containedView: screen)
    navigationController.pushViewController(hostingController, animated: true)
  }

  @ViewBuilder
  private func makeComponentSampleScreen(
    for destination: ComponentsLibraryViewModel.ComponentDestination
  ) -> some View {
    switch destination {
    case .inputFields:
      InputFieldSampleScreen()
    case .buttons:
      ButtonsSampleScreen()
    case .chips:
      ChipsSampleScreen()
    case .listCells:
      ListCellsSampleScreen()
    case .cards:
      CardsSampleScreen()
    case .avatars:
      AvatarSampleScreen()
    case .accountCards:
      AccountCardSampleScreen()
    case .horizontalPager:
      HorizontalPagerSampleScreen()
    }
  }
}
