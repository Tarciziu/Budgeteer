//
//  OnboardingWelcomeViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine

public final class OnboardingWelcomeViewModel: ObservableObject {
  // MARK: - Nested Types

  public enum OutputEvent: Equatable {
    /// The user finished the intro carousel and wants to start account setup.
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
