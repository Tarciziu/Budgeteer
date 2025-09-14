//
//  SceneDelegate.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 04.09.2025.
//

import UIKit
import FactoryKit

/// Main scene delegate, responsible for window and scene related operations
class SceneDelegate: NSObject, UIWindowSceneDelegate {
  // MARK: - Private Properties

  var mainWindow: MainWindow?
  let mainWindowViewModel = Container.shared.mainWindowViewModel()

  // MARK: - UIWindowSceneDelegate Methods

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    setupWindow(in: windowScene)
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    mainWindowViewModel.handleAppStateChange(newEvent: .wilEnterForeground)
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    mainWindowViewModel.handleAppStateChange(newEvent: .didEnterBackground)
  }

  // MARK: - Private Methods

  private func setupWindow(in windowScene: UIWindowScene) {
    mainWindow = MainWindow(windowScene: windowScene)
    mainWindow?.makeKeyAndVisible()
  }
}
