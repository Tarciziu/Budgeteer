//
//  DefaultUserPreferences.swift
//  Core
//
//  Created by Tarciziu Gologan on 05.09.2025.
//

import Foundation

/// A concrete implementation of the `UserPreferences` protocol using `UserDefaults` for storage.
public struct DefaultUserPreferences: UserPreferences {
  // MARK: - Private Properties

  private let defaults: UserDefaults = .standard

  // MARK: - Initializer
  public init() {
    /// Nothing to be initialized as the entity uses the standard UserDefaults.
  }

  // MARK: - UserPreferences conformance

  public func write<T>(_ value: T, forKey key: String) {
    defaults.setValue(value, forKey: key)
    defaults.synchronize()
  }

  public func read<T>(_: T.Type, forKey key: String) -> T? {
    let object = defaults.object(forKey: key)
    return object as? T
  }

  public func bool(forKey key: String) -> Bool {
    defaults.bool(forKey: key)
  }

  public func doesExist(forKey key: String) -> Bool {
    if defaults.dictionaryRepresentation().contains(where: { $0.key == key }) {
      return true
    }
    return false
  }

  public func wipe() {
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
      defaults.removeObject(forKey: key)
    }
  }
}
