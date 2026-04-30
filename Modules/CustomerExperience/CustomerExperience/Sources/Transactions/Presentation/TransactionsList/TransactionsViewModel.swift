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
  @Published var searchText = ""
  @Published var activeFilters: [TransactionFilter] = []
  @Published var isFilterSheetPresented = false

  // MARK: - Private Properties

  private let mapper = TransactionsUIMapper()
  private let categoryMapper = TransactionCategoryUIMapper()
  private let getTransactionsUseCase: GetTransactionsUseCase
  private let configuration: TransactionsConfiguration
  private let eventSubject = PassthroughSubject<TransactionsOutputEvent, Never>()
  private var allTransactions: [TransactionDM] = []

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
    allTransactions = transactions
    applyFiltersAndSearch()
  }

  // MARK: - Internal Methods

  func handleNewTransaction() {
    eventSubject.send(.didTapTransaction())
  }

  func handleTransactionTap(transactionIdentifier: String) {
    eventSubject.send(.didTapTransaction(transactionIdentifier: transactionIdentifier))
  }

  func presentFilterSheet() {
    isFilterSheetPresented = true
  }

  func applyFilters(_ filters: [TransactionFilter]) {
    activeFilters = filters
    applyFiltersAndSearch()
  }

  func removeFilter(_ filter: TransactionFilter) {
    activeFilters.removeAll { $0.id == filter.id }
    applyFiltersAndSearch()
  }

  func resetFilters() {
    activeFilters = []
    searchText = ""
    applyFiltersAndSearch()
  }

  func updateSearch() {
    applyFiltersAndSearch()
  }

  // MARK: - Private Methods

  private func applyFiltersAndSearch() {
    guard !allTransactions.isEmpty else { return }
    var filtered = allTransactions

    for filter in activeFilters {
      filtered = apply(filter: filter, to: filtered)
    }

    if !searchText.isEmpty {
      filtered = applySearch(text: searchText, to: filtered)
    }

    let transactionsList = TransactionsListUIModel.full(mapper.map(transactions: filtered))
    transactions = .loaded(transactionsList)
  }

  private func apply(filter: TransactionFilter, to transactions: [TransactionDM]) -> [TransactionDM] {
    switch filter {
    case let .beforeDate(date):
      return transactions.filter { Calendar.current.compare($0.transactionDate, to: date, toGranularity: .day) != .orderedDescending }
    case let .afterDate(date):
      return transactions.filter { Calendar.current.compare($0.transactionDate, to: date, toGranularity: .day) != .orderedAscending }
    case let .betweenDates(start, end):
      return transactions.filter { transaction in
        let notBefore = Calendar.current.compare(transaction.transactionDate, to: start, toGranularity: .day) != .orderedAscending
        let notAfter = Calendar.current.compare(transaction.transactionDate, to: end, toGranularity: .day) != .orderedDescending
        return notBefore && notAfter
      }
    case let .category(category):
      let domainCategory = categoryMapper.map(category)
      return transactions.filter { $0.categories.contains(domainCategory) }
    }
  }

  private func applySearch(text: String, to transactions: [TransactionDM]) -> [TransactionDM] {
    let lowercased = text.lowercased()
    return transactions.filter { transaction in
      transaction.title.lowercased().contains(lowercased)
      || (transaction.description?.lowercased().contains(lowercased) ?? false)
      || mapper.mapAmount(transaction.amount).lowercased().contains(lowercased)
      || categoryMapper.mapCategoriesLabel(transaction.categories).lowercased().contains(lowercased)
      || DateFormatterStore().hyphenDateFormatter.string(from: transaction.transactionDate).contains(lowercased)
    }
  }
}

// MARK: - Constants

extension TransactionsViewModel {
  enum Constants {
    static let screenTitle =
    Strings.CustomerExperience.singular("transactionsScreen.title")
  }
}
