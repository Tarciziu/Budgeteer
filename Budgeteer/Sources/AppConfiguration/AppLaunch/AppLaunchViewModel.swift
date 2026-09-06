//
//  AppLaunchViewModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 04.09.2025.
//

import Foundation
import BTCoreUI
import BTBusinessCore
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
  private let getBudgetPlansUseCase: GetBudgetPlansUseCase

  // MARK: - Init

  init(
    notificationsHandler: LocalNotificationsHandler,
    getBudgetPlansUseCase: GetBudgetPlansUseCase
  ) {
    self.notificationsHandler = notificationsHandler
    self.getBudgetPlansUseCase = getBudgetPlansUseCase
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
    Task { await resolveInitialPhase() }
  }

  /// Decides the initial phase from the data layer: a stored budget plan means the user already
  /// completed onboarding. A failed read routes to the initialisation-failure screen.
  @MainActor
  func resolveInitialPhase() async {
    do {
      let plans = try await getBudgetPlansUseCase.getBudgetPlans()
      appPhase = plans.isEmpty ? .newCustomerSetup : .mainApp
    } catch {
      appPhase = .initialisationFailure
    }
  }

  /// Transitions the app to its main phase once onboarding is done (the budget plan is persisted by
  /// the onboarding flow itself, so there is nothing else to record here).
  func completeOnboarding() {
    appPhase = .mainApp
  }
}
