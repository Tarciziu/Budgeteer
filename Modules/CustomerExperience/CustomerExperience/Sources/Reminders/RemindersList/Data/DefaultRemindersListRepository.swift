//
//  DefaultRemindersListRepository.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import BTCore

/// Default implementation of `DefaultRemindersListRepository`.
final public class DefaultRemindersListRepository: RemindersListRepository {
  // MARK: - Private Properties

  private let mapper = RemindersListDataMapper()
  private let dataSource: UserDataSource

  // MARK: - Init

  /// Creates a new `DefaultRemindersListRepository`.
  /// - Parameter dataSource: The data source used to fetch cached information.
  public init(dataSource: UserDataSource) {
    self.dataSource = dataSource
  }
}
