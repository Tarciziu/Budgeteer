//
//  PageControlColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 18/08/2026.
//

import SwiftUI

/// A structure representing various page control colors used throughout the application.
public struct PageControlColors {
  // MARK: - Public Properties

  /// The selected page control color.
  public let selected: Color
  /// The unselected page control color.
  public let unselected: Color

  // MARK: - Initializer

  /// Initializes a new instance of `BorderColors`.
  /// - Parameters:
  ///   - primary: The selected page control color.
  ///   - negative: The unselected page control color.
  public init(selected: Color, unselected: Color) {
    self.selected = selected
    self.unselected = unselected
  }
}
