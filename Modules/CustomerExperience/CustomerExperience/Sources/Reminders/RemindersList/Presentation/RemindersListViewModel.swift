//
//  RemindersListViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Combine

/// Presentation layer entity responsible for operating the reminders list page.
final public class RemindersListViewModel: ObservableObject {
  // MARK: - Published Properties

  @Published var uiModel: RemindersListUIModel

  // MARK: - Private Properties

  private let interactor: RemindersListInteractor
  private let mapper = RemindersListUIMapper()

  // MARK: - Init

  /// Creates a new `RemindersListViewModel`
  /// - Parameter interactor: The interactor associated with the feature.
  public init(interactor: RemindersListInteractor) {
    self.interactor = interactor
    uiModel = mapper.map()
  }
}
