//
//  DeveloperMenuCoordinator.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 06.01.2026.
//

import Combine
import UIKit
import BTCoreUI

class DeveloperMenuCoordinator {
  // MARK: - Nested Types

  enum DeveloperMenuFlowEvent {
    case close
  }

  // MARK: - Internal Properties

  var eventPublisher: AnyPublisher<DeveloperMenuFlowEvent, Never> {
    eventSubject.eraseToAnyPublisher()
  }
  var cancellables: [AnyCancellable] = []

  // MARK: - Private Properties

  private let rootNavigationController: UINavigationController
  let navigationController = BTNavigationController()
  private let eventSubject = PassthroughSubject<DeveloperMenuFlowEvent, Never>()

  // MARK: - Initializer

  init(rootNavigationController: UINavigationController) {
    self.rootNavigationController = rootNavigationController
  }

  // MARK: - Deinit

  deinit {
    for cancellable in cancellables {
      cancellable.cancel()
    }
    cancellables.removeAll()
  }

  // MARK: - Internal Methods

  func start() {
    let viewController = makeDeveloperMenuScreen()
    navigationController.viewControllers = [viewController]
    navigationController.isModalInPresentation = true
    rootNavigationController.present(navigationController, animated: true)
  }

  // MARK: - Internal Methods

  func handleCloseFlow() {
    navigationController.dismiss(animated: true)
    eventSubject.send(.close)
  }
}
