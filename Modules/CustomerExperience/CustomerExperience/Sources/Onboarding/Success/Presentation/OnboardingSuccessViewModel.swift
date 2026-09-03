//
//  OnboardingSuccessViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine

/// View model responsible for the presenation layer of the `OnboardingSuccessScreen`,
public final class OnboardingSuccessViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Entity indicating the events produced by this view model.
  public enum OutputEvent: Equatable {
    /// Signal triggered when the user requests navigation to the post registration phase(default it's home screen).
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

  /// Creates a new `OnboardingSuccessViewModel`,
  /// - Parameter selections: The model contaning the data selected by the user.
  public init(selections: OnboardingSelections = .placeholder) {
    self.uiModel = mapper.map(selections: selections)
  }

  // MARK: - Internal Methods

  func handleGoToHomeTap() {
    eventsSubject.send(.goToHomeRequested)
  }
}
