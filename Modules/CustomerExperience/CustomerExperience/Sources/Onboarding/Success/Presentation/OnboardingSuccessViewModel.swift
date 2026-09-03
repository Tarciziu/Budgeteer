//
//  OnboardingSuccessViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine

public final class OnboardingSuccessViewModel: ObservableObject {
  // MARK: - Nested Types

  public enum OutputEvent: Equatable {
    /// The user is done and wants to enter the main app.
    case goToHomeRequested
  }

  // MARK: - Published Properties

  @Published var uiModel: OnboardingSuccessUIModel

  public var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let mapper = OnboardingSuccessUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  // MARK: - Init

  public init(selections: OnboardingSelections = .placeholder) {
    self.uiModel = mapper.map(selections: selections)
  }

  // MARK: - Internal Methods

  func handleGoToHomeTap() {
    eventsSubject.send(.goToHomeRequested)
  }
}
