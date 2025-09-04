//
//  BTTheme.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 03.09.2025.
//

import Foundation

// MARK: - BTTheme Definition

/// The main theme structure that holds various design tokens and styles used throughout the application.
@Observable
public class BTTheme {
  // MARK: - Theme Components

  /// The currently used typography inside the application.
  public var typography: Typography

  /// The currently used color palette inside the application.
  public var spacing: Spacing

  // MARK: - Lifecycle

  public init(
    typography: Typography,
    spacing: Spacing
  ) {
    self.typography = typography
    self.spacing = spacing
  }
}
