//
//  MainWindow.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 04.09.2025.
//

import FactoryKit

import UIKit
import Combine

import BTCoreUI

/// Main UI window used in the app.
final class MainWindow: UIWindow {
  // MARK: - Private Properties

  private var mainTabBarController: MainTabBarController?
  private var onboardingCoordinator: OnboardingCoordinator?
  private let mainWindowViewModel = Container.shared.appLaunchViewModel()
  private let appLaunchViewModel = Container.shared.appLaunchViewModel()
  private var mainNavigationController = BTNavigationController()
  private var appPhaseCancellable: AnyCancellable?
  private var localNotificationsCancellable: AnyCancellable?
#if DEVELOPER_MENU_ENABLED
  private var developerMenuCoordinator: DeveloperMenuCoordinator?
  private var developerMenuSubscription: AnyCancellable?
#endif

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
    appPhaseCancellable = appLaunchViewModel.$appPhase.sink { [weak self] phase in
      self?.handlePhase(phase)
    }
  }

  private func handlePhase(_ phase: AppPhase) {
    switch phase {
    case .newCustomerSetup:
      handleOnboardingPhase()
    case .mainApp:
      handleMainAppPhase()
    default:
      // TODO: - Implement when necessary
      return
    }
  }

  private func handleOnboardingPhase() {
    let coordinator = OnboardingCoordinator(
      navigationController: mainNavigationController
    ) { [weak self] in
      self?.appLaunchViewModel.completeOnboarding()
    }
    onboardingCoordinator = coordinator
    coordinator.start()
  }

  private func handleMainAppPhase() {
    onboardingCoordinator = nil
    let tabBarController = MainTabBarController()
    mainTabBarController = tabBarController
    mainNavigationController.isNavigationBarHidden = true
    mainNavigationController.setViewControllers([tabBarController], animated: true)
    // TODO: - Decide at which step the user will be asked about notifications permisions.
    // If the user get's asked during the registration phase, this method sohuld be moved to the corresponding function.
    monitorLocalNotifications()
  }
}

private extension MainWindow {
  private func monitorLocalNotifications() {
    localNotificationsCancellable =
    appLaunchViewModel.notificationsHandlerOutputPublisher.sink { [weak self] event in
      self?.handleNotificationsEvent(event)
    }
  }

  private func handleNotificationsEvent(_ event: LocalNotificationEvent) {
    mainTabBarController?.process(event)
  }
}

// MARK: - Developer menu entry point.

#if DEVELOPER_MENU_ENABLED
extension MainWindow {
  override func becomeFirstResponder() -> Bool {
    true
  }

  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    switch motion {
    case .motionShake:
      presentDeveloperMenu()
    default: break
    }
  }

  private func presentDeveloperMenu() {
    let developerMenuCoordinator = DeveloperMenuCoordinator(rootNavigationController: mainNavigationController)

    developerMenuSubscription = developerMenuCoordinator.eventPublisher.sink { [weak self] event in
      switch event {
      case .close:
        self?.developerMenuSubscription?.cancel()
        self?.developerMenuSubscription = nil
        self?.developerMenuCoordinator = nil
      }
    }

    self.developerMenuCoordinator = developerMenuCoordinator
    developerMenuCoordinator.start()
  }
}
#endif
