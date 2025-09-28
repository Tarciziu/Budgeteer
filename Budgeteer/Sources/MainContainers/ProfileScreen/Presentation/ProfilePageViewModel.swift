//
//  ProfilePageViewModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 27.09.2025.
//

import Foundation

final class ProfilePageViewModel: ObservableObject {
  // MARK: - Published Properties

  @Published var uiModel: ProfilePageUIModel

  // MARK: - Private Properties

  private let mapper = ProfilePageUIMapper()

  // MARK: - Init

  init(interactor: ProfilePageInteractor) {
    self.uiModel = ProfilePageUIMapper().map()
  }
}
