//
//  LoadableContent.swift
//  Core
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import Foundation

/// Specifies the state of the content.
public enum LoadableContent<Content, Failure> {
  case loaded(Content)
  case isLoading(Content?)
  case empty
  case failed(Failure?)

  /// Specifies if the content is currently loading or not.
  public var isLoading: Bool {
    guard case .isLoading = self else {
      return false
    }
    return true
  }

  /// Retrieves the current content value if exists, otherwise nil.
  public var content: Content? {
    switch self {
    case .loaded(let content):
      return content
    case .isLoading(let content):
      return content
    case .empty:
      return nil
    case .failed:
      return nil
    }
  }

  /// Retrieves the current failure value if failed, otherwise nil.
  public var failure: Failure? {
    guard case .failed(let failure) = self else {
      return nil
    }
    return failure
  }
}

extension LoadableContent: Equatable where Content: Equatable, Failure: Equatable {}

extension LoadableContent: Hashable where Content: Hashable, Failure: Hashable {}
