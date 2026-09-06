//
//  OnboardingBudgetPeriodViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine

/// Presentation layer entity responsible for the screen displaying the inital budget configuration screen.
public final class OnboardingBudgetPeriodViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Entity indicating the events produced by this view model.
  public enum OutputEvent: Equatable {
    /// Signal emited wthen the user requested navigation back to the previous step.
    case backRequested
    /// Signal emited wthen the user wants to continue to the onboarding finish screen.
    case createRequested
  }

  // MARK: - Published Properties

  @Published var uiModel: OnboardingBudgetPeriodUIModel

  // MARK: - Public Properties

  public var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let mapper = OnboardingBudgetPeriodUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  // MARK: - Init

  /// Creates a new `OnboardingBudgetPeriodViewModel`.
  public init() {
    self.uiModel = mapper.map()
  }

  // MARK: - Internal Methods

  func handleBackTap() {
    eventsSubject.send(.backRequested)
  }

  func handleCreateTap() {
    eventsSubject.send(.createRequested)
  }
}
