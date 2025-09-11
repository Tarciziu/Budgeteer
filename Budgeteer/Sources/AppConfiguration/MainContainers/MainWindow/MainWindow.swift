//
//  MainWindow.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 04.09.2025.
//

import FactoryKit

import UIKit
import Combine
import SwiftUI

/// Main UI window used in the app.
final class MainWindow: UIWindow {
  // MARK: - Private Properties

  private let mainWindowViewModel = Container.shared.appLaunchViewModel()
  private let appLaunchViewModel = Container.shared.appLaunchViewModel()
  private var mainNavigationController = UINavigationController()
  private var cancellable: AnyCancellable?

  // MARK: - Init

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(windowScene: UIWindowScene) {
    super.init(windowScene: windowScene)
    self.rootViewController = mainNavigationController
    observeAppLaunchViewModel()
  }

  // MARK: - Private Methods

  private func observeAppLaunchViewModel() {
    cancellable = appLaunchViewModel.$appPhase.sink { [weak self] phase in
      self?.handlePhase(phase)
    }
  }

  private func handlePhase(_ phase: AppPhase) {
    switch phase {
    case .newCustomerSetup:
      handleRegistrationPhase()
    case .mainApp:
      handleMainAppPhase()
    default:
      // TODO: - Implement when necessary
      return
    }
  }

  private func handleRegistrationPhase() {
    let registrationScreen = RegistrationScreen { [weak self] in
      self?.appLaunchViewModel.handlePhase(.mainApp)
    }

    let hostingController = UIHostingController(rootView: registrationScreen)
    mainNavigationController.isNavigationBarHidden = true
    mainNavigationController.setViewControllers([hostingController], animated: true)
  }

  private func handleMainAppPhase() {
    mainNavigationController.isNavigationBarHidden = true
    mainNavigationController.setViewControllers([MainTabBarController()], animated: true)
  }
}

// MARK: - Developer menu entry point.
// TODO: - Move these lines of code behind compiler flags.
extension MainWindow {
  override func becomeFirstResponder() -> Bool {
    true
  }

  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    let developerMenuScreen = DeveloperMenu()
    let hostingController = UIHostingController(rootView: developerMenuScreen)
    mainNavigationController.present(hostingController, animated: true)
  }
}
