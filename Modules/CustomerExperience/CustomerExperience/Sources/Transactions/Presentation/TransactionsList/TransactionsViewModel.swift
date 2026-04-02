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
  public enum TransactionsOutputEvent {
    case didTapTransaction(transactionIdentifier: String? = nil)
    case didTapExpand /// Only for compact transaction list type.
  }

  // MARK: - Public Properties

  public var eventPublisher: AnyPublisher<TransactionsOutputEvent, Never> {
    eventSubject.eraseToAnyPublisher()
  }

  // MARK: - Published Properties

  @Published var transactions: LoadableContent<TransactionsListUIModel, String> = .empty

  // MARK: - Private Properties

  private let mapper = TransactionsUIMapper()
  private let getTransactionsUseCase: GetTransactionsUseCase
  private let configuration: TransactionsConfiguration
  private let eventSubject = PassthroughSubject<TransactionsOutputEvent, Never>()

  // MARK: - Lifecycle

  /// Initializes a new instance of ``TransactionsViewModel``.
  /// - Parameters:
  ///   - getTransactionsUseCase: Instance of ``GetTransactionsUseCase``.
  ///   - configuration: ``TransactionsConfiguration`` providing information about the transactions mode (compact or full).
  public init(getTransactionsUseCase: GetTransactionsUseCase, configuration: TransactionsConfiguration) {
    self.getTransactionsUseCase = getTransactionsUseCase
    self.configuration = configuration
  }

  // MARK: - Public Methods

  @MainActor
  public func loadTransactions() async {
    transactions = .isLoading(nil)
    guard let transactions = try? await getTransactionsUseCase.getTransactions() else {
      transactions = .failed(nil)
      return
    }
    let transactionsList = TransactionsListUIModel.full(mapper.map(transactions: transactions))
    self.transactions = .loaded(transactionsList)
  }

  // MARK: - Internal Methods

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
