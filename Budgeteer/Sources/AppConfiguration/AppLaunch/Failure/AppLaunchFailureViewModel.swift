//
//  AppLaunchFailureViewModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import Combine
import BTBusinessCore

/// Presentation layer entity for the initialisation-failure screen.
///
/// Owns the retry: it re-reads the stored budget plans and, on success, emits ``OutputEvent`` so the
/// window can move on to onboarding or the main app.
final class AppLaunchFailureViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Entity indicating the events produced by this view model.
  enum OutputEvent: Equatable {
    /// The retry succeeded; the app should transition to `phase`.
    case retrySucceeded(AppPhase)
  }

  // MARK: - Published Properties

  @Published var uiModel: AppLaunchFailureUIModel
  @Published private(set) var isRetrying = false

  // MARK: - Internal Properties

  var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let getBudgetPlansUseCase: GetBudgetPlansUseCase
  private let mapper = AppLaunchFailureUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  // MARK: - Init

  /// Creates a new `AppLaunchFailureViewModel`.
  /// - Parameter getBudgetPlansUseCase: Used to re-check the stored budget plans on retry.
  init(getBudgetPlansUseCase: GetBudgetPlansUseCase) {
    self.getBudgetPlansUseCase = getBudgetPlansUseCase
    self.uiModel = mapper.map()
  }

  // MARK: - Internal Methods

  func handleRetryTap() {
    guard !isRetrying else { return }
    isRetrying = true

    Task { @MainActor [weak self] in
      guard let self else { return }
      do {
        let plans = try await getBudgetPlansUseCase.getBudgetPlans()
        isRetrying = false
        eventsSubject.send(.retrySucceeded(plans.isEmpty ? .newCustomerSetup : .mainApp))
      } catch {
        isRetrying = false
      }
    }
  }
}
