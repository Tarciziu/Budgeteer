//
//  DefaultTransactionsRepository.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation
import SwiftData

/// The default implementation of ``TransactionsRepository``.
public class DefaultTransactionsRepository: TransactionsRepository {
  // MARK: - Private Properties

  private let modelContext: ModelContext?
  private let mapper = TransactionsDataMapper()

  // MARK: - Initializer

  /// Creates a new instance of ``DefaultTransactionsRepository``.
  /// - Parameter modelContext: Instance of ``ModelContext``.
  public init(modelContext: ModelContext?) {
    self.modelContext = modelContext
  }

  // MARK: - Read

  public func getTransactions() throws -> [TransactionDM] {
    guard let modelContext else {
      throw TransactionsError.missingDatabase
    }
    var descriptor = FetchDescriptor<TransactionDTO>()
    descriptor.sortBy = [SortDescriptor(\TransactionDTO.transactionDate, order: .reverse)]
    do {
      let models = try modelContext.fetch(descriptor)
      return try mapper.map(from: models)
    } catch {
      throw TransactionsError.internalInconsistency
    }
  }

  // MARK: - Create

  @discardableResult
  public func create(parameters: TransactionParametersDM) throws -> TransactionDM {
    guard let modelContext else {
      throw TransactionsError.missingDatabase
    }
    let transaction = mapper.map(from: parameters)
    modelContext.insert(transaction)
    do {
      try modelContext.save()
      return try mapper.map(from: transaction)
    } catch {
      throw TransactionsError.internalInconsistency
    }
  }

  // MARK: - Delete

  public func delete(_ transaction: TransactionDM) throws {
    guard let modelContext else {
      throw TransactionsError.missingDatabase
    }
    do {
      let transactionIdentifier: PersistentIdentifier = try mapper.map(from: transaction)
      let predicate = #Predicate<TransactionDTO> { model in
        model.persistentModelID == transactionIdentifier
      }
      try modelContext.delete(model: TransactionDTO.self, where: predicate)
      try modelContext.save()
    } catch {
      throw TransactionsError.internalInconsistency
    }
  }
}
