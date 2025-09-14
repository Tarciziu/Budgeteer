//
//  AppLaunchViewModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 04.09.2025.
//

import Foundation
import BTCoreUI
import FactoryKit

/// Main view model responsible for handling the app launch.
final class AppLaunchViewModel {
  // MARK: - Published Properties

  @Published var appPhase: AppPhase = .initialisation

  // MARK: - Internal Methods

  func handlePhase(_ phase: AppPhase) {
    self.appPhase = phase
  }

  func handleLaunch() {
    // This is designed to be called mainly from the app delegate since it's the first entry point of the app.
    // As the app grows, additional logic will have to be set here, in order to do the transition to other phases.
    // The phases will be used in other cases as well. Such as the main window in order to do the root navigation.
    AppearanceManager.sharedInstance.setTheme(Container.shared.theme())
    appPhase = .newCustomerSetup
  }
}
