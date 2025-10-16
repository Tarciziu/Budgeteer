//
//  SecurityKey.swift
//  Core
//
//  Created by Tarciziu Gologan on 12.10.2025.
//

import Foundation
import Security

/// Keys used for storing and retrieving items from the keychain.
public enum SecurityKey: String {
  // MARK: - Nested Types

  /// Accessibility options for keychain items.
  public enum Accessible: String {
    case afterFirstUnlock
    case afterFirstUnlockThisDeviceOnly
    case whenPasscodeSetThisDeviceOnly
    case whenUnlocked
    case whenUnlockedThisDeviceOnly

    public var rawValue: String {
      return switch self {
      case .afterFirstUnlock:
        Security.kSecAttrAccessibleAfterFirstUnlock as String
      case .afterFirstUnlockThisDeviceOnly:
        Security.kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly as String
      case .whenPasscodeSetThisDeviceOnly:
        Security.kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly as String
      case .whenUnlocked:
        Security.kSecAttrAccessibleWhenUnlocked as String
      case .whenUnlockedThisDeviceOnly:
        Security.kSecAttrAccessibleWhenUnlockedThisDeviceOnly as String
      }
    }
  }

  // MARK: - Keys

  case kSecAttrAccessible
  case kSecAttrAccount
  case kSecAttrGeneric
  case kSecAttrService
  case kSecAttrServer
  case kSecAttrAccessGroup
  case kSecAttrAccessControl
  case kSecClass
  case kSecClassGenericPassword
  case kSecClassIdentity
  case kSecClassInternetPassword
  case kSecClassKey
  case kSecMatchLimit
  case kSecMatchLimitOne
  case kSecReturnAttributes
  case kSecReturnData
  case kSecReturnPersistentRef
  case kSecReturnRef
  case kSecValueData
  case kSecUseAuthenticationContext

  public var rawValue: String {
    return switch self {
    case .kSecAttrAccessible:
      Security.kSecAttrAccessible as String
    case .kSecAttrAccount:
      Security.kSecAttrAccount as String
    case .kSecAttrGeneric:
      Security.kSecAttrGeneric as String
    case .kSecAttrService:
      Security.kSecAttrService as String
    case .kSecAttrServer:
      Security.kSecAttrServer as String
    case .kSecAttrAccessGroup:
      Security.kSecAttrAccessGroup as String
    case .kSecAttrAccessControl:
      Security.kSecAttrAccessControl as String
    case .kSecClass:
      Security.kSecClass as String
    case .kSecClassGenericPassword:
      Security.kSecClassGenericPassword as String
    case .kSecClassIdentity:
      Security.kSecClassIdentity as String
    case .kSecClassInternetPassword:
      Security.kSecClassInternetPassword as String
    case .kSecClassKey:
      Security.kSecClassKey as String
    case .kSecMatchLimit:
      Security.kSecMatchLimit as String
    case .kSecMatchLimitOne:
      Security.kSecMatchLimitOne as String
    case .kSecReturnAttributes:
      Security.kSecReturnAttributes as String
    case .kSecReturnData:
      Security.kSecReturnData as String
    case .kSecReturnPersistentRef:
      Security.kSecReturnPersistentRef as String
    case .kSecReturnRef:
      Security.kSecReturnRef as String
    case .kSecValueData:
      Security.kSecValueData as String
    case .kSecUseAuthenticationContext:
      Security.kSecUseAuthenticationContext as String
    }
  }
}
