//
//  Keychain.swift
//  Core
//
//  Created by Tarciziu Gologan on 12.10.2025.
//

import Foundation

public typealias KeychainAttributes = [SecurityKey: Any]

/// A protocol defining methods for interacting with the Keychain.
public protocol Keychain {
  /// Retrieves the value for a specified attributes from the Keychain.
  /// - Parameters:
  ///   - type: The type of the value to be retrieved.
  ///   - key: The key identifying the value in the keychain.
  ///   - attributesProvider: A provider that supplies additional attributes needed for the keychain query.
  /// - Returns: The value associated with the specified key, if it exists.
  func read<T, Provider>(
    _ type: T.Type,
    for key: Provider.Key,
    attributesProvider: Provider
  ) throws -> T where T: Decodable, Provider: KeychainAttributesProvider

  /// Retrieves a custom encoded value for the specified attributes from the Keychain.
  /// - Parameters:
  ///   - decoder: A closure that decodes the retrieved data into the desired type.
  ///   - key: The key identifying the value in the keychain.
  ///   - attributesProvider: A provider that supplies additional attributes needed for the keychain query.
  /// - Returns: The decoded value associated with the specified key, if it exists.
  func read<T, Provider>(
    decoder: @escaping (Data) throws -> T,
    for key: Provider.Key,
    attributesProvider: Provider
  ) throws -> T where T: Decodable, Provider: KeychainAttributesProvider

  /// Retrieves the item for the specified attributes from the Keychain as a dictionary.
  /// - Parameters:
  ///   - key: The key identifying the value in the keychain.
  ///   - attributesProvider: A provider that supplies additional attributes needed for the keychain query.
  /// - Returns: A dictionary containing the item's attributes, if it exists.
  func read<Provider>(
    for key: Provider.Key,
    attributesProvider: Provider
  ) throws -> [String: Any] where Provider: KeychainAttributesProvider

  /// Sets a value for the specified attributes in the Keychain.
  /// - Parameters:
  ///   - value: The value to be stored in the keychain.
  ///   - key: The key identifying the value in the keychain.
  ///   - attributesProvider: A provider that supplies additional attributes needed for the keychain query.
  func set<Provider>(
    value: some Encodable,
    for key: Provider.Key,
    attributesProvider: Provider
  ) throws where Provider: KeychainAttributesProvider

  /// Sets a custom encoded value for the specified attributes in the Keychain.
  /// - Parameters:
  ///   - data: The data to be stored in the keychain.
  ///   - key: The key identifying the value in the keychain.
  ///   - attributesProvider: A provider that supplies additional attributes needed for the keychain query.
  func set<Provider>(
    data: Data,
    for key: Provider.Key,
    attributesProvider: Provider
  ) throws where Provider: KeychainAttributesProvider

  /// Deletes the value for the specified attributes from the Keychain.
  /// - Parameters:
  ///   - key: The key identifying the value in the keychain.
  ///   - attributesProvider: A provider that supplies additional attributes needed for the keychain query.
  func remove<Provider>(
    _ key: Provider.Key,
    attributesProvider: Provider
  ) throws where Provider: KeychainAttributesProvider

  /// Erases entire Keychain content related to the application.
  func wipe() throws
}
