//
//  View+Convenience.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 30.08.2025.
//

import SwiftUI

extension View {
  /// Applies the loading environment value to the view.
  /// - Parameter isLoading: A boolean value that determines whether the loading state is active.
  /// - Returns: Modified environment for the following views.
  public func isLoading(_ isLoading: Bool) -> some View {
    environment(\.isLoading, isLoading)
  }

  /// Applies the enabled environment value to the view.
  /// - Parameter isEnabled: A boolean value that determines whether the view is enabled.
  /// - Returns: Modified environment for the following views.
  public func isEnabled(_ isEnabled: Bool) -> some View {
    environment(\.isEnabled, isEnabled)
  }
}
