//
//  Currency.swift
//  BusinessCore
//
//  Created by Adrian-Zoltan Herczeg on 07.01.2026.
//

import Foundation

/// Type mapping supported currencies in the app.
public enum CurrencyDM: Equatable, Codable, CaseIterable {
  case eur
  case usd

  /// Default currency of the app.
  public static let defaultCurrency: CurrencyDM = .eur
}
