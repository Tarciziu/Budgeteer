//
//  NumberFormatterStore.swift
//  Core
//
//  Created by Tarciziu Gologan on 31.12.2025.
//

import Foundation

/// Entity responsible for storing number formatters.
public class NumberFormatterStore {
  // MARK: - Nested Types

  private enum Constants {
    static let minimumFractionDigits = 2
    static let maximumFractionDigits = 2
  }

  // MARK: - Public Properties

  /// Amount formatter for Input Field's visual transformation.
  public lazy private(set) var amountInputFormatter: NumberFormatter = {
    makeAmountInputFormatter()
  }()

  /// Amount formatter for displaying transaction amounts.
  public lazy private(set) var amountFormatter: NumberFormatter = {
    makeAmountFormatter()
  }()

  // MARK: - Initializer

  /// Initializes a new ``NumberFormattersStore``.
  public init() {
    /// Nothing to be initialized.
  }

  // MARK: - Private Methods

  private func makeAmountInputFormatter() -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = Constants.maximumFractionDigits
    return formatter
  }

  private func makeAmountFormatter() -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = Constants.minimumFractionDigits
    formatter.maximumFractionDigits = Constants.maximumFractionDigits
    return formatter
  }
}
