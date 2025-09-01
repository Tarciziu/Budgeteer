//
//  UserDataSourceKeys.swift
//  Core
//
//  Created by Adrian-Zoltan Herczeg on 28.08.2025.
//

import Foundation

/// Type responsible for holding the identifiers used as keys for the in memory storage of the user data source.
public enum UserDataSourceInMemoryKey: String, Identifiable, CaseIterable {
  public var id: String {
    self.rawValue
  }

  case name
  case age
}
