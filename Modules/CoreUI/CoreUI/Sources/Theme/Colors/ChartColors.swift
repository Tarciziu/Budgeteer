//
//  ChartColors.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import SwiftUI

// MARK: - Chart Color Palette Definition

/// A structure representing the categorical colors used to fill chart segments.
public struct ChartColors {
  // MARK: - Public Properties

  /// The color for the highest-ranked segment.
  public let one: Color
  /// The color for the second-ranked segment.
  public let two: Color
  /// The color for the third-ranked segment.
  public let three: Color

  // MARK: - Initializer

  /// Initializes a new instance of `ChartColors`.
  /// - Parameters:
  ///   - one: The color for the highest-ranked segment.
  ///   - two: The color for the second-ranked segment.
  ///   - three: The color for the third-ranked segment.
  public init(
    one: Color,
    two: Color,
    three: Color
  ) {
    self.one = one
    self.two = two
    self.three = three
  }
}
