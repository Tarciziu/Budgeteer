//
//  TransactionsListViewModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Combine

/// Entity responsible with handling the presentation logic for the transactions list screen.
public class TransactionsListViewModel: ObservableObject {
  // TODO: Replace with actual model when available & use loadable component.
  @Published var transactions: [String] = []

  // MARK: - Private Properties

  private let mapper = TransactionsListUIMapper()
  private let interactor: TransactionsInteractor

  // MARK: - Lifecycle

  /// Initializes a new instance of ``TransactionsListViewModel``.
  /// - Parameter interactor: Instance of ``TransactionsInteractor``.
  public init(interactor: TransactionsInteractor) {
    self.interactor = interactor
  }
}
