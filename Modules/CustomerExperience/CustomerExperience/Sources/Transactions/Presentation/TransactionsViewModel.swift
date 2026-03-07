//
//  TransactionsViewModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Combine
import BTCore

/// Entity responsible with handling the presentation logic for the transactions list screen.
public class TransactionsViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Events emitted by the `TransactionsViewModel`.
  public enum TransactionsOutputEvents {
    case didTapTransaction(transactionIdentifier: String)
    case didTapExpand /// Only for compact transaction list type.
  }

  // MARK: - Public Properties

  public var eventPublisher: AnyPublisher<TransactionsOutputEvents, Never> {
    eventSubject.eraseToAnyPublisher()
  }

  // MARK: - Published Properties

  // TODO: Replace with actual model when available & use loadable component.
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

  func loadTransactions() {
    transactions = .isLoading(nil)
    do {
      let fetchedTransactions = try interactor.getTransactions()
      let transactionsList = TransactionsListUIModel.full(mapper.map(transactions: fetchedTransactions))
      self.transactions = .loaded(transactionsList)
    } catch {
      self.transactions = .failed(nil)
    }
  }
}
