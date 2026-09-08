//
//  TransactionDetailsViewModel.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 29/03/2026.
//

import Combine
import BTCore
import BTBusinessCore
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
  @Published private(set) var budgetPlans: [TransactionBudgetPlanUIModel] = []
  @Published var isBudgetPlanSheetPresented = false
  @Published private(set) var isOperationOngoing = false
  @Published var validationMessage: String?

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

  var validationAlertTitle: String {
    localizedStrings.validationAlertTitle
  }

  var validationAlertDismissTitle: String {
    localizedStrings.validationAlertDismissTitle
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
  private let getBudgetPlansUseCase: GetBudgetPlansUseCase

  // MARK: - Initializer

  /// Initializes ``TransactionDetailsViewModel``.
  /// - Parameters:
  ///   - transactionIdentifier: Unique identifier of the transaction.
  ///   - createTransactionUseCase: Instance of ``CreateTransactionUseCase``.
  ///   - updateTransactionUseCase: Instance of ``UpdateTransactionUseCase``.
  ///   - getTransactionUseCase: Instance of ``GetTransactionUseCase``.
  ///   - getBudgetPlansUseCase: Instance of ``GetBudgetPlansUseCase``.
  public init(
    transactionIdentifier: String?,
    createTransactionUseCase: CreateTransactionUseCase,
    updateTransactionUseCase: UpdateTransactionUseCase,
    getTransactionUseCase: GetTransactionUseCase,
    getBudgetPlansUseCase: GetBudgetPlansUseCase
  ) {
    self.transactionIdentifier = transactionIdentifier
    self.createTransactionUseCase = createTransactionUseCase
    self.updateTransactionUseCase = updateTransactionUseCase
    self.getTransactionUseCase = getTransactionUseCase
    self.getBudgetPlansUseCase = getBudgetPlansUseCase
    let emptyModel = mapper.makeEmptyTransactionModel()
    model = emptyModel
    initialModel = emptyModel
  }

  // MARK: - Internal Methods

  func selectCategory(_ category: TransactionCategoryUIModel) {
    model.category = model.category == category ? nil : category
  }

  func selectBudgetPlan(_ budgetPlan: TransactionBudgetPlanUIModel) {
    model.budgetPlan = budgetPlan
  }

  func presentBudgetPlanSheet() {
    isBudgetPlanSheetPresented = true
  }

  func requestDismiss() {
    eventSubject.send(.dismiss)
  }

  func dismissValidationAlert() {
    validationMessage = nil
  }

  /// Loads the data backing the screen. The budget plans are always fetched first; the existing
  /// transaction (edit mode) is only loaded afterwards, from ``handle(_:)`` for the plans result.
  func load() {
    Task {
      do {
        let plans = try await getBudgetPlansUseCase.getBudgetPlans()
        await handle(plans)
      } catch {
        // TODO: Handle Error
      }
    }
  }

  func saveTransaction() {
    guard !isOperationOngoing else { return }
    guard let parameters = validatedParameters() else { return }
    isOperationOngoing = true
    if let transactionIdentifier {
      updateTransaction(id: transactionIdentifier, parameters: parameters)
    } else {
      createTransaction(parameters: parameters)
    }
  }

  func getCategories() -> [TransactionCategoryUIModel] {
    categoryMapper.allCategories()
  }

  // MARK: - Private Methods

  /// Handles the fetched budget plans and, when editing, chains the transaction request.
  @MainActor
  private func handle(_ plans: [BudgetPlanDM]) {
    budgetPlans = mapper.mapBudgetPlans(plans)
    applyDefaultBudgetPlanSelection()
    loadTransactionIfNeeded()
  }

  /// Handles the fetched transaction, seeding the editable model and its baseline.
  @MainActor
  private func handle(_ transaction: TransactionDM) {
    let mappedModel = mapper.map(from: transaction)
    model = mappedModel
    initialModel = mappedModel
    applyDefaultBudgetPlanSelection()
  }

  /// Fetches the existing transaction (edit mode only). Kept non-isolated so the use-case call runs
  /// off the main actor; the result is applied on the main actor via ``handle(_:)``.
  private func loadTransactionIfNeeded() {
    guard let transactionIdentifier else { return }
    Task {
      do {
        let transaction = try await getTransactionUseCase.getTransaction(id: transactionIdentifier)
        await handle(transaction)
      } catch {
        // TODO: Handle Error
      }
    }
  }

  /// Resolves ``TransactionDetailsUIModel/budgetPlan`` against the fetched ``budgetPlans``: it keeps
  /// the plan matching the current id (edit mode) and otherwise defaults to the first plan. Also
  /// mirrors the resolved plan into ``initialModel`` while editing so the auto-selection does not
  /// register as a user edit.
  @MainActor
  private func applyDefaultBudgetPlanSelection() {
    guard !budgetPlans.isEmpty else { return }
    let resolved = budgetPlans.first { $0.id == model.budgetPlan.id } ?? budgetPlans[0]
    guard resolved != model.budgetPlan else { return }
    model.budgetPlan = resolved
    if isEditMode {
      initialModel.budgetPlan = resolved
    }
  }

  /// Validates the current model and returns the domain parameters, or `nil` if validation fails.
  /// When validation fails, ``validationMessage`` is populated so the UI can surface an alert.
  private func validatedParameters() -> TransactionParametersDM? {
    guard model.category != nil else {
      validationMessage = localizedStrings.missingCategoryMessage
      return nil
    }
    return mapper.mapParameters(transaction: model)
  }

  private func createTransaction(parameters: TransactionParametersDM) {
    Task { @MainActor in
      do {
        try await createTransactionUseCase.createTransaction(parameters)
        eventSubject.send(.successful)
        isOperationOngoing = false
      } catch {
        // TODO: Handle Error
      }
    }
  }

  private func updateTransaction(id: String, parameters: TransactionParametersDM) {
    Task { @MainActor in
      do {
        try await updateTransactionUseCase.updateTransaction(
          id: id,
          parameters: parameters
        )
        eventSubject.send(.successful)
        isOperationOngoing = false
      } catch {
        isOperationOngoing = false
      }
    }
  }
}
