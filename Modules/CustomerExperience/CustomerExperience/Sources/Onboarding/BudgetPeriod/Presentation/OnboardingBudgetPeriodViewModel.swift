//
//  OnboardingBudgetPeriodViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine

public final class OnboardingBudgetPeriodViewModel: ObservableObject {
  // MARK: - Nested Types

  public enum OutputEvent: Equatable {
    case backRequested
    case createRequested
  }

  // MARK: - Published Properties

  @Published var uiModel: OnboardingBudgetPeriodUIModel

  public var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let mapper = OnboardingBudgetPeriodUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  // MARK: - Init

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
