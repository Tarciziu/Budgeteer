//
//  BorderColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 21.10.2025.
//

import SwiftUI

/// A structure representing various border colors used throughout the application.
public struct BorderColors {
  // MARK: - Public Properties

  /// The primary border color.
  public let primary: Color
  /// The negative border color.
  public let negative: Color

  // MARK: - Initializer

  /// Initializes a new instance of `BorderColors`.
  /// - Parameters:
  ///   - primary: The primary border color.
  ///   - negative: The negative border color.
  public init(primary: Color, negative: Color) {
    self.primary = primary
    self.negative = negative
  }
}
