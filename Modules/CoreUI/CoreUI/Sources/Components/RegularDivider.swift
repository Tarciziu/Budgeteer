//
//  Divider.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 25.09.2025.
//

import SwiftUI

/// An UI component capable of separating content vertically.
public struct RegularDivider: View {
  // MARK: - Environment

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Initializer

  /// Creates a new regular divider.
  public init() {
    /// Nothing to be set.
  }

  // MARK: - Body

  public var body: some View {
    Rectangle()
      .foregroundStyle(theme.colorPalette.surface.overlay) // TODO: Replace when adding border color catalog
      .frame(height: theme.spacing.lineWidth)
  }
}
