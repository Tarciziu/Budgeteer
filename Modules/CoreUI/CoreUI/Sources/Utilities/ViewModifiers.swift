//
//  ViewModifiers.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 30.08.2025.
//

import SwiftUI

public extension View {
  /// Applies the given transformation if the given condition evaluates to `true`.
  /// - Parameters:
  ///   - condition: Condition to be evaluated.
  ///   - transform: The transformation to apply to the source `View`.
  /// - Returns: Original view or the modified view if the condition is met.
  @ViewBuilder
  func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
