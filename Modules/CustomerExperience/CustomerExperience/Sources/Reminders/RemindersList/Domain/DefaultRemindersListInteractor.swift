//
//  DefaultRemindersListInteractor.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Foundation

/// Default implementation of the `RemindersListInteractor`.
final public class DefaultRemindersListInteractor: RemindersListInteractor {
  // MARK: - Private Properties

  private let repository: RemindersListRepository

  // MARK: - Init

  /// Creates a new `DefaultRemindersListInteractor`.
  /// - Parameter repository: The data layer entity used for information retrieval.
  public init(repository: RemindersListRepository) {
    self.repository = repository
  }
}
