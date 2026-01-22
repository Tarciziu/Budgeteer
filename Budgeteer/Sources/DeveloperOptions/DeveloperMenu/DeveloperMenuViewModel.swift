//
//  DeveloperMenuViewModel.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 08.01.2026.
//

import Combine
import Foundation

@Observable
class DeveloperMenuViewModel {
  // MARK: - Nested Types

  enum FlowEvent {
    case close
  }

  // MARK: - Internal Properties

  var eventPublisher: AnyPublisher<FlowEvent, Never> {
    eventSubject.eraseToAnyPublisher()
  }

  // MARK: - Private Properties

  private var eventSubject = PassthroughSubject<FlowEvent, Never>()

  // MARK: - Internal Methods

  func close() {
    eventSubject.send(.close)
  }
}
