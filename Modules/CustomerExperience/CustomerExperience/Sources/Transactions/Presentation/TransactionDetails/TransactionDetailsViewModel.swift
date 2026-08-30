//
//  TransactionDetailsViewModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 29/03/2026.
//

import Combine
import BTCore
import Foundation

/// Entity responsible with handling the presentation logic for the new transaction and transaction details screens.
public class TransactionDetailsViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Events emitted by the `TransactionsViewModel`.
  @frozen
  public enum TransactionOutputEvent {
    case dismiss
    case successful
  }

  // MARK: - Published Properties

  @Published var model: TransactionDetailsUIModel
  @Published private(set) var isOperationOngoing = false

  // MARK: - Public Properties

  public var eventPublisher: AnyPublisher<TransactionOutputEvent, Never> {
    eventSubject.eraseToAnyPublisher()
  }

  // MARK: - Internal Properties

  let localizedStrings = LocalizedStrings()

  var isEditMode: Bool {
    transactionIdentifier != nil
  }

  var isActionEnabled: Bool {
    !isEditMode || model != initialModel
  }

  var actionLabel: String {
    isEditMode ? localizedStrings.updateActionLabel : localizedStrings.saveActionLabel
  }

  // MARK: - Private Properties

  private let categoryMapper = TransactionCategoryUIMapper()
  private let mapper = TransactionDetailsUIMapper()
  private let eventSubject = PassthroughSubject<TransactionOutputEvent, Never>()
  private var initialModel: TransactionDetailsUIModel

  // MARK: - Dependencies

  private let transactionIdentifier: String?
  private let createTransactionUseCase: CreateTransactionUseCase
  private let updateTransactionUseCase: UpdateTransactionUseCase
  private let getTransactionUseCase: GetTransactionUseCase

  // MARK: - Initializer

  /// Initializes ``TransactionDetailsViewModel``.
  /// - Parameters:
  ///   - transactionIdentifier: Unique identifier of the transaction.
  ///   - createTransactionUseCase: Instance of ``CreateTransactionUseCase``.
  ///   - updateTransactionUseCase: Instance of ``UpdateTransactionUseCase``.
  ///   - getTransactionUseCase: Instance of ``GetTransactionUseCase``.
  public init(
    transactionIdentifier: String?,
    createTransactionUseCase: CreateTransactionUseCase,
    updateTransactionUseCase: UpdateTransactionUseCase,
    getTransactionUseCase: GetTransactionUseCase
  ) {
    self.transactionIdentifier = transactionIdentifier
    self.createTransactionUseCase = createTransactionUseCase
    self.updateTransactionUseCase = updateTransactionUseCase
    self.getTransactionUseCase = getTransactionUseCase
    let emptyModel = mapper.makeEmptyTransactionModel()
    model = emptyModel
    initialModel = emptyModel
  }

  // MARK: - Internal Methods

  func toggleCategory(_ category: TransactionCategoryUIModel) {
    if model.categories.contains(category) {
      model.categories.remove(category)
    } else {
      model.categories.insert(category)
    }
  }

  func requestDismiss() {
    eventSubject.send(.dismiss)
  }

  func loadTransaction() {
    guard let transactionIdentifier else { return }
    Task {
      do {
        let transaction = try await getTransactionUseCase.getTransaction(id: transactionIdentifier)
        let mappedModel = mapper.map(from: transaction)
        await MainActor.run {
          model = mappedModel
          initialModel = mappedModel
        }
      } catch {
        // TODO: Handle Error
      }
    }
  }

  func saveTransaction() {
    guard !isOperationOngoing else { return }
    isOperationOngoing = true
    if let transactionIdentifier {
      updateTransaction(id: transactionIdentifier)
    } else {
      createTransaction()
    }
  }

  func getCategories() -> [TransactionCategoryUIModel] {
    categoryMapper.allCategories()
  }

  // MARK: - Private Methods

  private func createTransaction() {
    Task { @MainActor in
      do {
        try await createTransactionUseCase.createTransaction(mapper.mapParameters(transaction: model))
        eventSubject.send(.successful)
        isOperationOngoing = false
      } catch {
        // TODO: Handle Error
      }
    }
  }

  private func updateTransaction(id: String) {
    Task { @MainActor in
      do {
        try await updateTransactionUseCase.updateTransaction(
          id: id,
          parameters: mapper.mapParameters(transaction: model)
        )
        eventSubject.send(.successful)
        isOperationOngoing = false
      } catch {
        isOperationOngoing = false
      }
    }
  }
}
