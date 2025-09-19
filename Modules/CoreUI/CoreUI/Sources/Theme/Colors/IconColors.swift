//
//  IconColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 19.09.2025.
//

import SwiftUI

// MARK: - Icon Color Palette Definition

/// Type containing icon colors used all over the application.
public struct IconColors {
  // MARK: - Public Properties

  public let primary: Color
  public let secondary: Color
  public let positive: Color
  public let negative: Color
  public let disabled: Color

  // MARK: - Initializer

  public init(primary: Color, secondary: Color, positive: Color, negative: Color, disabled: Color) {
    self.primary = primary
    self.secondary = secondary
    self.positive = positive
    self.negative = negative
    self.disabled = disabled
  }
}
