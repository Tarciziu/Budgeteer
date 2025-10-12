//
//  KeychainConfiguration.swift
//  Core
//
//  Created by Tarciziu Gologan on 12.10.2025.
//

import Foundation

/// Protocol defining the configuration required for Keychain operations.
public protocol KeychainConfiguration {
  /// The service identifier for the Keychain item.
  var service: String { get }
  /// The accessibility level for the Keychain item.
  var accessible: SecurityKey.Accessible { get }
  /// The access control settings for the Keychain item, if any.
  var group: String? { get }
}

/// Default implementation of `KeychainConfiguration` with standard settings.
public struct DefaultKeychainConfiguration: KeychainConfiguration {
  // MARK: - Private Properties

  public let service: String
  public let accessible: SecurityKey.Accessible
  public let group: String?

  // MARK: - Initializer

  /// Initializes a new instance of `DefaultKeychainConfiguration`.
  /// - Parameters:
  ///   - service: The service identifier for the Keychain item.
  ///   - accessible: The accessibility level for the Keychain item.
  ///   - group: The access control settings for the Keychain item, if any.
  public init(
    service: String = "BudgeteerKeychain",
    accessible: SecurityKey.Accessible = .whenUnlockedThisDeviceOnly,
    group: String? = nil
  ) {
    self.service = service
    self.accessible = accessible
    self.group = group
  }
}
