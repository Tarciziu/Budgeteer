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
    !model.title.isEmpty && !model.amount.isEmpty
  }

  var actionLabel: String {
    isEditMode ? localizedStrings.updateActionLabel : localizedStrings.saveActionLabel
  }

  // MARK: - Private Properties

  private let mapper: TransactionDetailsUIMapper
  private let eventSubject = PassthroughSubject<TransactionOutputEvent, Never>()

  // MARK: - Dependencies

  private let transactionIdentifier: String?
  private let createTransactionUseCase: CreateTransactionUseCase

  // MARK: - Initializer

  /// Initializes ``TransactionDetailsViewModel``.
  /// - Parameters:
  ///   - transactionIdentifier: Unique identifier of the transaction.
  ///   - createTransactionUseCase: Instance of ``CreateTransactionUseCase``.
  public init(
    transactionIdentifier: String?,
    createTransactionUseCase: CreateTransactionUseCase
  ) {
    self.transactionIdentifier = transactionIdentifier
    self.createTransactionUseCase = createTransactionUseCase
    mapper = TransactionDetailsUIMapper()
    model = mapper.makeEmptyTransactionModel()
  }

  // MARK: - Internal Methods

  func requestDismiss() {
    eventSubject.send(.dismiss)
  }

  func saveTransaction() {
    guard !isOperationOngoing else { return }
    isOperationOngoing = true
    if transactionIdentifier != nil {
      // TODO: Handle update
    } else {
      createTransaction()
    }
  }

  // MARK: - Private Methods

  private func createTransaction() {
    Task { @MainActor in
      do {
        try await createTransactionUseCase.createTransaction(mapper.mapParameters(transaction: model))
        eventSubject.send(.successful)
      } catch {
        isOperationOngoing = false
      }
    }
  }
}
