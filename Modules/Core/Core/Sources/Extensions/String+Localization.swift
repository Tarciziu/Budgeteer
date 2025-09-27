//
//  String+Localization.swift
//  Core
//
//  Created by Tarciziu Gologan on 27.09.2025.
//

import SwiftUI

// MARK: - LocalizationContainer definition

/// A protocol that defines the requirements for a localization container.
public protocol LocalizationContainer {
  /// The bundle where the localization files are stored.
  static var localizationBundle: Bundle { get }
  /// The table name for the localization files.
  static var localizationTable: String? { get }
}

// MARK: - LocalizationCatalog definition

/// A type that provides access to localized strings for a specific localization container.
public enum LocalizedStrings<Container: LocalizationContainer> {
  public static func singular(
    _ key: String,
    comment: String = String()
  ) -> String {
    NSLocalizedString(
      key,
      tableName: Container.localizationTable,
      bundle: Container.localizationBundle,
      comment: comment
    )
  }
}

// MARK: - Strings namespace

/// Namespace for localized strings.
public struct Strings {
  private init() {}
}
