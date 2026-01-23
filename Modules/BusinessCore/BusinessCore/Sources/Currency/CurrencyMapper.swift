//
//  CurrencyMapper.swift
//  BusinessCore
//
//  Created by Adrian-Zoltan Herczeg on 07.01.2026.
//

import Foundation

/// Universal mapper used to manipulate the different currencies.
public struct CurrencyMapper {
  // MARK: - Nested Types

  private enum Constants {
    static let usd = "USD"
    static let eur = "EUR"
  }

  // MARK: - Init

  /// No property to be initialized.
  public init() {}

  // MARK: - Public Methods

  public func map(currency: CurrencyDM) -> String {
    switch currency {
    case .eur:
      Constants.eur
    case .usd:
      Constants.usd
    }
  }

  public func map(currency: String) -> CurrencyDM? {
    switch currency {
    case Constants.usd:
      return .usd
    case Constants.eur:
      return .eur
    default:
      return nil
    }
  }
}
