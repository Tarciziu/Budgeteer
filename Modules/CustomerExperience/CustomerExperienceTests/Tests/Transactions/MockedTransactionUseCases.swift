//
//  MockedTransactionUseCases.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import InstantMock
@testable import BTCustomerExperience

/// InstantMock based test doubles for the transaction use cases.
///
/// Every argument is forwarded to `callThrowing(...)`, so registrations must describe each argument
/// with an `Arg` matcher (`Arg<String>.any()`, `Arg<String>.eq(...)`) or an `ArgumentCaptor` when
/// the received value needs to be asserted.

final class MockedCreateTransactionUseCase: Mock, CreateTransactionUseCase {
  init() {
    super.init(SwiftTestingMock.factory)
  }

  func createTransaction(_ creationDM: TransactionParametersDM) async throws {
    try callThrowing(creationDM)
  }
}

final class MockedUpdateTransactionUseCase: Mock, UpdateTransactionUseCase {
  init() {
    super.init(SwiftTestingMock.factory)
  }

  func updateTransaction(id: String, parameters: TransactionParametersDM) async throws {
    try callThrowing(id, parameters)
  }
}

final class MockedGetTransactionUseCase: Mock, GetTransactionUseCase {
  init() {
    super.init(SwiftTestingMock.factory)
  }

  func getTransaction(id: String) async throws -> TransactionDM {
    try callThrowing(id) ?? TransactionDataGenerator.transactionDM()
  }
}
