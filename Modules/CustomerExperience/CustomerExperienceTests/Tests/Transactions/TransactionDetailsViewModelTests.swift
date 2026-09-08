//
//  TransactionDetailsViewModelTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import Foundation
import Testing
import Combine
import InstantMock
import BTBusinessCore

@testable import BTCustomerExperience

@MainActor
struct TransactionDetailsViewModelTests {
  // MARK: - Nested Types

  private enum TestError: Error {
    case failed
  }

  private enum Constants {
    static let plans: [BudgetPlanDM] = [
      BudgetPlanDataGenerator.budgetPlanDM(id: "bp-1", name: "Household"),
      BudgetPlanDataGenerator.budgetPlanDM(id: "bp-2", name: "Travel"),
      BudgetPlanDataGenerator.budgetPlanDM(id: "bp-3", name: "Savings")
    ]

    static let groceries = TransactionCategoryUIModel(type: .groceries, title: "Groceries")
  }

  // MARK: - Private Properties

  private let budgetPlansUseCase = MockedGetBudgetPlansUseCase()
  private let createUseCase = MockedCreateTransactionUseCase()
  private let updateUseCase = MockedUpdateTransactionUseCase()
  private let getUseCase = MockedGetTransactionUseCase()

  // MARK: - Helpers

  private func makeViewModel(transactionIdentifier: String? = nil) -> TransactionDetailsViewModel {
    TransactionDetailsViewModel(
      transactionIdentifier: transactionIdentifier,
      createTransactionUseCase: createUseCase,
      updateTransactionUseCase: updateUseCase,
      getTransactionUseCase: getUseCase,
      getBudgetPlansUseCase: budgetPlansUseCase
    )
  }

  private func stubBudgetPlans(_ plans: [BudgetPlanDM]) async throws {
    budgetPlansUseCase.stub().call(try await budgetPlansUseCase.getBudgetPlans()).andReturn(plans)
  }

  private func waitUntil(
    _ condition: @escaping () -> Bool,
    iterations: Int = 200
  ) async {
    for _ in 0..<iterations {
      if condition() { return }
      try? await Task.sleep(for: .milliseconds(5))
    }
  }

  private func waitForSuccessfulEvent(
    on viewModel: TransactionDetailsViewModel,
    while act: () -> Void
  ) async {
    var cancellable: AnyCancellable?
    await withCheckedContinuation { continuation in
      var resumed = false
      cancellable = viewModel.eventPublisher.sink { event in
        guard case .successful = event, !resumed else { return }
        resumed = true
        continuation.resume()
      }
      act()
    }
    cancellable?.cancel()
  }

  // MARK: - Tests

  @Test("`load()` fetches the budget plans and exposes their names.")
  func test_Load_PopulatesBudgetPlans() async throws {
    // Given
    try await stubBudgetPlans(Constants.plans)
    let viewModel = makeViewModel()

    // When
    viewModel.load()
    await waitUntil { !viewModel.budgetPlans.isEmpty }

    // Then
    #expect(viewModel.budgetPlans.map(\.id) == ["bp-1", "bp-2", "bp-3"])
    #expect(viewModel.budgetPlans.map(\.name) == ["Household", "Travel", "Savings"])
  }

  @Test("For a new transaction the first fetched budget plan is selected by default.")
  func test_Load_NewTransaction_SelectsFirstBudgetPlan() async throws {
    // Given
    try await stubBudgetPlans(Constants.plans)
    let viewModel = makeViewModel()

    // When
    viewModel.load()
    await waitUntil { !viewModel.budgetPlans.isEmpty }

    // Then
    #expect(viewModel.model.budgetPlan == viewModel.budgetPlans.first)
  }

  @Test("When the budget plans request fails the transaction is never requested.")
  func test_Load_WhenBudgetPlansFail_DoesNotLoadTransaction() async throws {
    // Given
    budgetPlansUseCase.stub()
      .call(try await budgetPlansUseCase.getBudgetPlans())
      .andThrow(TestError.failed)
    getUseCase.reject().call(try await getUseCase.getTransaction(id: Arg<String>.any()))
    let viewModel = makeViewModel(transactionIdentifier: "tx-1")

    // When
    viewModel.load()
    // Let the (rejected) chained request run before verifying its absence.
    try? await Task.sleep(for: .milliseconds(100))

    // Then
    getUseCase.verify()
    #expect(viewModel.budgetPlans.isEmpty)
  }

  @Test("`selectBudgetPlan(_:)` updates the selected plan on the model.")
  func test_SelectBudgetPlan_UpdatesModel() async throws {
    // Given
    try await stubBudgetPlans(Constants.plans)
    let viewModel = makeViewModel()
    viewModel.load()
    await waitUntil { !viewModel.budgetPlans.isEmpty }
    let secondPlan = viewModel.budgetPlans[1]

    // When
    viewModel.selectBudgetPlan(secondPlan)

    // Then
    #expect(viewModel.model.budgetPlan == secondPlan)
  }

  @Test("`presentBudgetPlanSheet()` flags the sheet as presented.")
  func test_PresentBudgetPlanSheet_SetsPresentedFlag() {
    // Given
    let viewModel = makeViewModel()
    #expect(viewModel.isBudgetPlanSheetPresented == false)

    // When
    viewModel.presentBudgetPlanSheet()

    // Then
    #expect(viewModel.isBudgetPlanSheetPresented)
  }

  @Test("Creating a transaction forwards the selected budget plan id.")
  func test_SaveTransaction_NewTransaction_ForwardsSelectedBudgetPlanId() async throws {
    // Given
    try await stubBudgetPlans(Constants.plans)
    let parametersCaptor = ArgumentCaptor<TransactionParametersDM>()
    createUseCase.expect().call(try await createUseCase.createTransaction(parametersCaptor.capture()))
    let viewModel = makeViewModel()
    viewModel.load()
    await waitUntil { !viewModel.budgetPlans.isEmpty }
    viewModel.selectBudgetPlan(viewModel.budgetPlans[2])
    viewModel.model.category = Constants.groceries

    // When
    await waitForSuccessfulEvent(on: viewModel) {
      viewModel.saveTransaction()
    }

    // Then
    createUseCase.verify()
    #expect(parametersCaptor.value?.budgetPlanId == "bp-3")
  }

  @Test("Editing a transaction requests it, preselects its plan and keeps the action disabled.")
  func test_Load_EditMode_PreselectsStoredPlanAndKeepsActionDisabled() async throws {
    // Given
    try await stubBudgetPlans(Constants.plans)
    let stored = TransactionDataGenerator.transactionDM(id: "tx-9", budgetPlanId: "bp-2")
    let idCaptor = ArgumentCaptor<String>()
    getUseCase.expect()
      .call(try await getUseCase.getTransaction(id: idCaptor.capture()))
      .andReturn(stored)
    let viewModel = makeViewModel(transactionIdentifier: "tx-9")

    viewModel.load()
    await waitUntil { viewModel.model.id == "tx-9" }

    getUseCase.verify()
    #expect(idCaptor.value == "tx-9")
    #expect(viewModel.model.budgetPlan.id == "bp-2")
    #expect(viewModel.model.budgetPlan.name == "Travel")
    #expect(viewModel.isActionEnabled == false)

    // When
    viewModel.model.title = "Updated title"

    // Then
    #expect(viewModel.isActionEnabled)
  }
}
