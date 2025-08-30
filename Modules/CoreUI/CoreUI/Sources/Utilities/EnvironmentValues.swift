//
//  EnvironmentValues.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 30.08.2025.
//

import SwiftUI

public extension EnvironmentValues {
  /// A boolean value that indicates whether a loading state is active.
  /// Default value is `false`.
  var isLoading: Bool {
    get { self[IsLoadingEnvironmentKey.self] }
    set { self[IsLoadingEnvironmentKey.self] = newValue }
  }
}

private struct IsLoadingEnvironmentKey: EnvironmentKey {
  static let defaultValue: Bool = false
}
