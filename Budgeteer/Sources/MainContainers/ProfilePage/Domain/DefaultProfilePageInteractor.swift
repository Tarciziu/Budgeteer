//
//  DefaultProfilePageInteractor.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 27.09.2025.
//

import Foundation

class DefaultProfilePageInteractor: ProfilePageInteractor {
  // MARK: - Private Properties

  private let repository: ProfilePageRepository

  // MARK: - Init

  init(repository: ProfilePageRepository) {
    self.repository = repository
  }
}
