//
//  AppLaunchViewModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 04.09.2025.
//

import Foundation
import BTCoreUI
import FactoryKit
import UserNotifications
import Combine

/// Main view model responsible for handling the app launch.
final class AppLaunchViewModel {
  // MARK: - Published Properties

  @Published var appPhase: AppPhase = .initialisation

  var notificationsHandlerOutputPublisher: AnyPublisher<LocalNotificationEvent, Never> {
    notificationsHandler.outputPublisher
  }

  // MARK: - Private Properties

  private let notificationsHandler: LocalNotificationsHandler
  private let onboardingState: OnboardingState

  // MARK: - Init

  init(
    notificationsHandler: LocalNotificationsHandler,
    onboardingState: OnboardingState
  ) {
    self.notificationsHandler = notificationsHandler
    self.onboardingState = onboardingState
  }

  // MARK: - Internal Methods

  func handlePhase(_ phase: AppPhase) {
    self.appPhase = phase
  }

  func handleLaunch() {
    // This is designed to be called mainly from the app delegate since it's the first entry point of the app.
    // As the app grows, additional logic will have to be set here, in order to do the transition to other phases.
    // The phases will be used in other cases as well. Such as the main window in order to do the root navigation.
    AppearanceManager.sharedInstance.setTheme(Container.shared.theme())
    UNUserNotificationCenter.current().delegate = notificationsHandler
    appPhase = onboardingState.hasCompletedOnboarding ? .mainApp : .newCustomerSetup
  }

  /// Marks onboarding as completed and transitions the app to its main phase.
  func completeOnboarding() {
    onboardingState.markOnboardingCompleted()
    appPhase = .mainApp
  }
}
