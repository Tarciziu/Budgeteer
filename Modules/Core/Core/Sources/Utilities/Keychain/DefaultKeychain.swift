//
//  DefaultKeychain.swift
//  Core
//
//  Created by Tarciziu Gologan on 12.10.2025.
//

import Foundation

public class DefaultKeychain: Keychain {
  // MARK: - Private Properties

  private let underlyingKeychainAccess = UnderlyingKeychainAccess()
  private let configuration: KeychainConfiguration
  private let jsonDecoder: JSONDecoder
  private let jsonEncoder: JSONEncoder

  // MARK: - Initializer

  /// Initializes a new instance of `DefaultKeychain`.
  /// - Parameter configuration: Instance of ``KeychainConfiguration``. Default value is ``DefaultKeychainConfiguration``.
  public init(
    configuration: KeychainConfiguration = DefaultKeychainConfiguration()
  ) {
    self.configuration = configuration
    self.jsonDecoder = JSONDecoder()
    self.jsonEncoder = JSONEncoder()
  }

  // MARK: - Public Methods

  public func read<T, Provider>(
    _ type: T.Type,
    for key: Provider.Key,
    attributesProvider: Provider = DefaultKeychainAttributesProvider()
  ) throws -> T where T: Decodable, Provider: KeychainAttributesProvider {
    let data = try internalValue(for: key, attributesProvider: attributesProvider)
    return try jsonDecoder.decode(T.self, from: data)
  }

  public func read<T, Provider>(
    decoder: @escaping (Data) throws -> T,
    for key: Provider.Key,
    attributesProvider: Provider = DefaultKeychainAttributesProvider()
  ) throws -> T where T: Decodable, Provider: KeychainAttributesProvider {
    let data = try internalValue(for: key, attributesProvider: attributesProvider)
    return try decoder(data)
  }

  public func read<Provider>(
    for key: Provider.Key,
    attributesProvider: Provider = DefaultKeychainAttributesProvider()
  ) throws -> [String: Any] where Provider: KeychainAttributesProvider {
    let attributes = attributesProvider.getSearchAttributes(for: key, configuration: configuration)
    return try underlyingKeychainAccess.getItem(matching: attributes)
  }

  public func set<Provider>(
    value: some Encodable,
    for key: Provider.Key,
    attributesProvider: Provider = DefaultKeychainAttributesProvider()
  ) throws where Provider: KeychainAttributesProvider {
    let data = try jsonEncoder.encode(value)
    try setValue(data: data, for: key, attributesProvider: attributesProvider)
  }

  public func set<Provider>(
    data: Data,
    for key: Provider.Key,
    attributesProvider: Provider = DefaultKeychainAttributesProvider()
  ) throws where Provider: KeychainAttributesProvider {
    try setValue(data: data, for: key, attributesProvider: attributesProvider)
  }

  public func remove<Provider>(
    _ key: Provider.Key,
    attributesProvider: Provider = DefaultKeychainAttributesProvider()
  ) throws where Provider: KeychainAttributesProvider {
    let removeQuery = attributesProvider.getRemoveAttributes(for: key, configuration: configuration)
    do {
      try underlyingKeychainAccess.deleteItem(matching: removeQuery)
    } catch let error as KeychainError {
      if error.status != errSecItemNotFound {
        throw error
      }
    }
  }

  public func wipe() throws {
    try underlyingKeychainAccess.wipe()
  }
}

// MARK: - Private Methods

extension DefaultKeychain {
  private func internalValue<Provider>(
    for key: Provider.Key,
    attributesProvider: Provider
  ) throws -> Data where Provider: KeychainAttributesProvider {
    let query = attributesProvider.getSearchAttributes(for: key, configuration: configuration)

    do {
      let queryResult = try underlyingKeychainAccess.getItem(matching: query)
      guard let data = queryResult[SecurityKey.kSecValueData.rawValue] as? Data else {
        throw KeychainError(
          operation: .get,
          key: query[.kSecAttrAccount] as? String,
          service: query[.kSecAttrService] as? String,
          status: errSecItemNotFound
        )
      }
      return data
    } catch let error as KeychainError {
      throw error
    }
  }

  private func setValue<Provider>(
    data: Data,
    for key: Provider.Key,
    attributesProvider: Provider
  ) throws where Provider: KeychainAttributesProvider {
    let query = attributesProvider.getWriteAttributes(for: key, configuration: configuration)

    do {
      try remove(key, attributesProvider: attributesProvider)
      var newItem = query
      newItem[.kSecValueData] = data as AnyObject?
      try underlyingKeychainAccess.addItem(with: newItem)
    } catch let error as KeychainError {
      throw error
    }
  }
}

// MARK: - Nested Types

extension DefaultKeychain {
  private struct UnderlyingKeychainAccess {
    func getItem(matching query: KeychainAttributes) throws -> [String: Any] {
      var queryResult: AnyObject?
      let status = SecItemCopyMatching(query.asCFDictionary, &queryResult)
      guard status == noErr else {
        throw KeychainError(
          operation: .get,
          key: query[.kSecAttrAccount] as? String,
          service: query[.kSecAttrService] as? String,
          status: status
        )
      }

      guard let result = queryResult as? [String: Any] else {
        throw KeychainError(
          operation: .get,
          key: query[.kSecAttrAccount] as? String,
          service: query[.kSecAttrService] as? String,
          status: errSecItemNotFound
        )
      }
      return result
    }

    func updateItem(matching query: KeychainAttributes, with attributesToUpdate: KeychainAttributes) throws {
      let status = SecItemUpdate(query.asCFDictionary, attributesToUpdate.asCFDictionary)
      guard status == noErr else {
        throw KeychainError(
          operation: .update,
          key: query[.kSecAttrAccount] as? String,
          service: query[.kSecAttrService] as? String,
          status: status
        )
      }
    }

    func addItem(with attributes: KeychainAttributes) throws {
      let status = SecItemAdd(attributes.asCFDictionary, nil)
      guard status == noErr else {
        throw KeychainError(
          operation: .add,
          key: attributes[.kSecAttrAccount] as? String,
          service: attributes[.kSecAttrService] as? String,
          status: status
        )
      }
    }

    func deleteItem(matching query: KeychainAttributes) throws {
      let status = SecItemDelete(query.asCFDictionary)
      guard status == noErr else {
        throw KeychainError(
          operation: .delete,
          key: query[.kSecAttrAccount] as? String,
          service: query[.kSecAttrService] as? String,
          status: status
        )
      }
    }

    func wipe() throws {
      let allClasses: [SecurityKey] = [
        .kSecClassKey,
        .kSecClassGenericPassword,
        .kSecClassInternetPassword,
        .kSecClassIdentity
      ]
      for secClass in allClasses {
        let query: [SecurityKey: Any] = [
          .kSecClass: secClass.rawValue
        ]
        let status = SecItemDelete(query.asCFDictionary)
        guard status != errSecItemNotFound else { continue }
        guard status == noErr else {
          throw KeychainError(
            operation: .wipe,
            service: query[.kSecAttrService] as? String,
            status: status
          )
        }
      }
    }
  }
}

// MARK: - Extensions

private extension Dictionary where Key == SecurityKey {
  var asCFDictionary: CFDictionary {
    var dictionary: [String: Any] = [:]
    for (key, value) in self {
      dictionary[key.rawValue] = value
    }
    return dictionary as CFDictionary
  }
}
