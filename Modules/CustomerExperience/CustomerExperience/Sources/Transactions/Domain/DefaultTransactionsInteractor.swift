//
//  DefaultTransactionsInteractor.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 03.10.2025.
//

import Foundation

/// Default implementation of `TransactionsInteractor`.
public class DefaultTransactionsInteractor: TransactionsInteractor {
  // MARK: - Private Properties

  private let transactionsRepository: TransactionsRepository

  // MARK: - Initializer

  /// Initializes a new instance of `DefaultTransactionsInteractor`.
  /// - Parameter transactionsRepository: Instance of ``TransactionsRepository``.
  public init(transactionsRepository: TransactionsRepository) {
    self.transactionsRepository = transactionsRepository
  }
}
