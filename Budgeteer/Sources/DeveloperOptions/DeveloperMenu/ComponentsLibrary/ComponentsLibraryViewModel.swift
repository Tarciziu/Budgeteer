//
//  ComponentsLibraryViewModel.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import Combine
import Foundation

@Observable
class ComponentsLibraryViewModel {
  // MARK: - Nested Types

  enum FlowEvent {
    case navigate(ComponentDestination)
  }

  enum ComponentDestination: CaseIterable {
    case inputFields
    case buttons
    case chips
    case listCells
    case cards
    case avatars
    case accountCards

    var title: String {
      switch self {
      case .inputFields: "Input Fields"
      case .buttons: "Buttons"
      case .chips: "Chips"
      case .listCells: "List Cells"
      case .cards: "Cards"
      case .avatars: "Avatars"
      case .accountCards: "Account Cards"
      }
    }

    var caption: String {
      switch self {
      case .inputFields: "Text input variants"
      case .buttons: "Regular and pill buttons"
      case .chips: "Chip buttons and groups"
      case .listCells: "Value and navigation cells"
      case .cards: "Card buttons and menu cells"
      case .avatars: "Avatar sizes and shapes"
      case .accountCards: "Account cards"
      }
    }

    var icon: String {
      switch self {
      case .inputFields: "character.textbox"
      case .buttons: "hand.tap"
      case .chips: "tag"
      case .listCells: "list.bullet"
      case .cards: "rectangle.on.rectangle"
      case .avatars: "person.circle"
      case .accountCards: "person.crop.circle"
      }
    }
  }

  // MARK: - Internal Properties

  var searchText = ""

  var filteredComponents: [ComponentDestination] {
    guard !searchText.isEmpty else {
      return ComponentDestination.allCases
    }
    let query = searchText.lowercased()
    return ComponentDestination.allCases.filter {
      $0.title.lowercased().contains(query) || $0.caption.lowercased().contains(query)
    }
  }

  var eventPublisher: AnyPublisher<FlowEvent, Never> {
    eventSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private var eventSubject = PassthroughSubject<FlowEvent, Never>()

  // MARK: - Internal Methods

  func navigate(to destination: ComponentDestination) {
    eventSubject.send(.navigate(destination))
  }
}
