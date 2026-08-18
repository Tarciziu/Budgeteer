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

// MARK: - View Size

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: ContainerSizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(ContainerSizePreferenceKey.self, perform: onChange)
  }
}

struct ContainerSizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
