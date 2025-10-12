//
//  KeychainError.swift
//  Core
//
//  Created by Tarciziu Gologan on 12.10.2025.
//

import Foundation

/// An error that occurs during Keychain operations.
public struct KeychainError: LocalizedError, CustomStringConvertible, Equatable {
  // MARK: - CustomStringConvertible conformance

  public var description: String {
    errorDescription ?? String(describing: self)
  }

  // MARK: - Public Properties

  /// The OSStatus code returned by the Keychain operation.
  public let status: OSStatus?
  /// The error description.
  public let errorMessage: String

  // MARK: - Internal Properties

  let operation: Operation
  let key: String?
  let service: String?

  // MARK: - Private Properties

  private let date = Date()

  // MARK: - Initializer

  /// Creates a new instance of ``KeychainError``.
  /// - Parameters:
  ///   - operation: The operation that caused the error.
  ///   - key: The key associated with the keychain item.
  ///   - service: The service associated with the keychain item.
  ///   - status: The OSStatus code returned by the Keychain operation.
  ///   - customErrorMessage: The error description.
  public init(
    operation: Operation,
    key: String? = nil,
    service: String? = nil,
    status: OSStatus? = nil,
    customErrorMessage: String? = nil
  ) {
    self.status = status
    self.operation = operation
    self.key = key
    self.service = service
    if let customErrorMessage {
      self.errorMessage = customErrorMessage
    } else if
      let status,
      let secErrorMessage = SecCopyErrorMessageString(status, nil) as String? {
      self.errorMessage = secErrorMessage
    } else {
      self.errorMessage = "Unknown error"
    }
  }

  // MARK: - LocalizedError conformance

  public var errorDescription: String? {
    let mirror = Mirror(reflecting: self)
    var result: [String: Any] = [:]
    for child in mirror.children {
      guard let label = child.label else { continue }
      if let operation = child.value as? Operation {
        result[label] = operation.rawValue
      } else {
        result[label] = child.value
      }
    }
    return "\(Self.self) \(result as NSDictionary)"
  }
}

// MARK: - Nested Types

extension KeychainError {
  /// The type of operation that caused the error.
  public enum Operation: String {
    case get
    case update
    case add
    case delete
    case wipe
    case encoding
    case decoding
  }
}
