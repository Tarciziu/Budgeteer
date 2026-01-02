//
//  ProfilePageViewModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 27.09.2025.
//

import Foundation
import Combine

final class ProfilePageViewModel: ObservableObject {
  // MARK: - Nested Types

  enum OutputEvent: Equatable {
    case externalNavigation(destination: URL)
    case internalNavigation(destination: InternalNavigationDestination)
  }

  enum InternalNavigationDestination: Equatable {
    case reminders
    case themeCustomization
    case feedback
  }

  // MARK: - Published Properties

  @Published var uiModel: ProfilePageUIModel
  var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private let mapper = ProfilePageUIMapper()
  private var eventsSubject = PassthroughSubject<OutputEvent, Never>()

  // MARK: - Init

  init() {
    self.uiModel = mapper.map()
  }

  // MARK: - Internal Methods

  func handleNavigationLinkTap(linkType: ProfilePageUIModel.LinkType) {
    switch linkType {
    case .suggestion:
      eventsSubject.send(.internalNavigation(destination: .feedback))
    case .remindersConfiguration:
      eventsSubject.send(.internalNavigation(destination: .reminders))
    case .theming:
      eventsSubject.send(.internalNavigation(destination: .themeCustomization))
    }
  }
}
