//
//  OnboardingWelcomeViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine

/// View model responsible for the initial screen in the onboarding flow.
public final class OnboardingWelcomeViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Entity indicating the events produced by this view model.
  public enum OutputEvent: Equatable {
    /// Signal emited when the user wants to proceed to the next screen in the onboarding flow.
    case getStarted
  }

  // MARK: - Published Properties

  @Published var uiModel: OnboardingWelcomeUIModel
  @Published var selectedSlideIndex: Int = 0

  public var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Computed Properties

  /// Label for the primary button, driven by the visible slide.
  var primaryButtonTitle: String {
    guard uiModel.slides.indices.contains(selectedSlideIndex) else { return String() }
    return uiModel.slides[selectedSlideIndex].ctaTitle
  }

  private var isOnLastSlide: Bool {
    selectedSlideIndex >= uiModel.slides.count - 1
  }

  // MARK: - Private Properties

  private let mapper = OnboardingWelcomeUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  // MARK: - Init

  /// Creates a new `OnboardingWelcomeViewModel`,
  public init() {
    self.uiModel = mapper.map()
  }

  // MARK: - Internal Methods

  /// Advances to the next slide, or emits `.getStarted` when already on the last one.
  func handlePrimaryButtonTap() {
    guard !isOnLastSlide else {
      eventsSubject.send(.getStarted)
      return
    }
    selectedSlideIndex += 1
  }
}
