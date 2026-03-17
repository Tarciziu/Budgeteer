//
//  TransactionsViewModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Combine
import BTCore
import Foundation

/// Entity responsible with handling the presentation logic for the transactions list screen.
public class TransactionsViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Events emitted by the `TransactionsViewModel`.
  public enum TransactionsOutputEvents {
    case didTapTransaction(transactionIdentifier: String? = nil)
    case didTapExpand /// Only for compact transaction list type.
  }

  // MARK: - Public Properties

  public var eventPublisher: AnyPublisher<TransactionsOutputEvents, Never> {
    eventSubject.eraseToAnyPublisher()
  }

  // MARK: - Published Properties

  @Published var transactions: LoadableContent<TransactionsListUIModel, String> = .empty

  // MARK: - Private Properties

  private let mapper = TransactionsUIMapper()
  private let interactor: TransactionsInteractor
  private let configuration: TransactionsConfiguration
  private let eventSubject = PassthroughSubject<TransactionsOutputEvents, Never>()

  // MARK: - Lifecycle

  /// Initializes a new instance of ``TransactionsViewModel``.
  /// - Parameters:
  ///   - interactor: Instance of ``TransactionsInteractor``.
  ///   - configuration: ``TransactionsConfiguration`` providing information about the transactions mode (compact or full).
  public init(interactor: TransactionsInteractor, configuration: TransactionsConfiguration) {
    self.interactor = interactor
    self.configuration = configuration
  }

  // MARK: - Internal Methods

  func loadTransactions() async {
    transactions = .isLoading(nil)
    guard let transactions = try? await interactor.getTransactions() else {
      transactions = .failed(nil)
      return
    }
    let transactionsList = TransactionsListUIModel.full(mapper.map(transactions: transactions))
    self.transactions = .loaded(transactionsList)
  }

  func handleNewTransaction() {
    eventSubject.send(.didTapTransaction())
  }
}

// MARK: - Constants

extension TransactionsViewModel {
  enum Constants {
    static let screenTitle =
    Strings.CustomerExperience.singular("transactionsScreen.title")
  }
}
