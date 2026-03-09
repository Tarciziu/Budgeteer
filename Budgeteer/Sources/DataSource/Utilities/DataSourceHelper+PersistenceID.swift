//
//  DataSource+PersistenceID.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 15.03.2026.
//

import Foundation
import SwiftData

/// Type serving as wrapper for different helper functions used at the local data source level.
extension DataSourceHelper {
  // MARK: - Internal Methods

  /// Transforms an id from the SwiftData representation to a string.
  /// - Parameter id: A `PersistentIdentifier` coresponding to a SwiftData model.
  /// - Returns: String representation of the SwiftData model id.
  func map(id: PersistentIdentifier) -> String? {
    let encoder = JSONEncoder()
    guard let identifierData = try? encoder.encode(id) else {
      return nil
    }
    let identifierString = String(data: identifierData, encoding: .utf8)
    return identifierString
  }

  /// Transforms an id from a string representation into a SwiftData identifier.
  /// - Parameter id: String identifier corresponding to a SwiftData `PersistentIdentifier`.
  /// - Returns: The decoded `PersistentIdentifier`.
  func map(from id: String) -> PersistentIdentifier? {
    let decoder = JSONDecoder()
    guard let data = id.data(using: .utf8) else {
      return nil
    }
    do {
      return try decoder.decode(PersistentIdentifier.self, from: data)
    } catch {
      return nil
    }
  }
}
