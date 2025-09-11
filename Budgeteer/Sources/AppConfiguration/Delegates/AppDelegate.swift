//
//  AppDelegate.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 04.09.2025.
//

import UIKit
import FactoryKit

/// First entry point in the app.
@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  // MARK: - Private Properties

  private let viewModel = Container.shared.appLaunchViewModel()

  // MARK: - UIApplicationDelegate Methods

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // Currently we do not need to handle the launch options.
    viewModel.handleLaunch()
    return true
  }
}
