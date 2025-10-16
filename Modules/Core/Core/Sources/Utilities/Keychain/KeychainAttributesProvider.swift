//
//  KeychainAttributesProvider.swift
//  Core
//
//  Created by Tarciziu Gologan on 12.10.2025.
//

import Foundation

/// A protocol that defines a provider for keychain attributes.
public protocol KeychainAttributesProvider {
  /// The type of the key used in the keychain.
  associatedtype Key

  /// Retrieves the attributes required for writing to the keychain.
  /// - Parameters:
  ///   - key: The key for which to retrieve attributes.
  ///   - configuration: The keychain configuration.
  /// - Returns: The attributes for reading from the keychain.
  func getWriteAttributes(for key: Key, configuration: KeychainConfiguration) -> KeychainAttributes

  /// Retrieves the attributes required for reading from the keychain.
  /// - Parameters:
  ///   - key: The key for which to retrieve attributes.
  ///   - configuration: The keychain configuration.
  /// - Returns: The attributes for writing to the keychain.
  func getSearchAttributes(for key: Key, configuration: KeychainConfiguration) -> KeychainAttributes

  /// Retrieves the attributes required for removing from the keychain.
  /// - Parameters:
  ///   - key: The key for which to retrieve attributes.
  ///   - configuration: The keychain configuration.
  /// - Returns: The attributes for removing from the keychain.
  func getRemoveAttributes(for key: Key, configuration: KeychainConfiguration) -> KeychainAttributes
}

/// The default implementation of `KeychainAttributesProvider`.
public struct DefaultKeychainAttributesProvider: KeychainAttributesProvider {
  // MARK: - Initializer

  /// Creates a new instance of `DefaultKeychainAttributesProvider`.
  public init() {
    /// Nothing to be initialized.
  }

  // MARK: - KeychainAttributesProvider conformance

  public func getWriteAttributes(for key: String, configuration: KeychainConfiguration) -> KeychainAttributes {
    return [
      .kSecClass: SecurityKey.kSecClassGenericPassword.rawValue,
      .kSecAttrAccount: key,
      .kSecAttrService: configuration.service,
      .kSecMatchLimit: SecurityKey.kSecMatchLimitOne.rawValue,
      .kSecReturnData: true,
      .kSecReturnPersistentRef: true
    ]
      .merging(configuration.group.map { [SecurityKey.kSecAttrAccessGroup: $0] } ?? [:]) { $1 }
  }

  public func getSearchAttributes(for key: String, configuration: any KeychainConfiguration) -> KeychainAttributes {
    return [
      .kSecClass: SecurityKey.kSecClassGenericPassword.rawValue,
      .kSecAttrAccount: key,
      .kSecAttrService: configuration.service,
      .kSecMatchLimit: SecurityKey.kSecMatchLimitOne.rawValue,
      .kSecReturnData: true,
      .kSecReturnPersistentRef: true
    ]
      .merging(configuration.group.map { [SecurityKey.kSecAttrAccessGroup: $0] } ?? [:]) { $1 }
  }

  public func getRemoveAttributes(for key: String, configuration: any KeychainConfiguration) -> KeychainAttributes {
    return [
      .kSecClass: SecurityKey.kSecClassGenericPassword.rawValue,
      .kSecAttrAccount: key,
      .kSecAttrService: configuration.service
    ]
      .merging(configuration.group.map { [SecurityKey.kSecAttrAccessGroup: $0] } ?? [:]) { $1 }
  }
}
