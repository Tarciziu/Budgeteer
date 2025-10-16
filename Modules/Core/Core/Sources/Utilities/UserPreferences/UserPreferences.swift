//
//  UserPreferences.swift
//  Core
//
//  Created by Tarciziu Gologan on 05.09.2025.
//

import Foundation

/// Protocol providing an interface for managing user preferences storage.
public protocol UserPreferences {
  /// Sets the value of the specified default key.
  /// - Parameters:
  ///   - value: The value to be stored in the user preferences storage.
  ///   - key: The key with which to associate the value.
  func write<T>(_ value: T, forKey key: String)

  /// Retrieves the value associated with the specified key.
  /// - Parameters:
  ///   - _: The type of the value to be retrieved.
  ///   - key: The key whose value to retrieve.
  /// - Returns: The value associated with the specified key, or `nil` if the key does not exist.
  func read<T>(_: T.Type, forKey key: String) -> T?

  /// Retrieves the boolean value associated with the specified key.
  /// - Parameter key: The key whose value to retrieve.
  /// - Returns: The boolean value associated with the specified key, or `false` if the key does not exist.
  func bool(forKey key: String) -> Bool

  /// Checks if a value exists for the specified key.
  /// - Parameter key: The key to check for existence.
  /// - Returns: `true` if a value exists for the specified key, otherwise `false`.
  func doesExist(forKey key: String) -> Bool

  /// Removes the value associated with the specified key.
  func wipe()
}
