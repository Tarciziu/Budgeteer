//
//  TextColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 19.09.2025.
//

import SwiftUI

// MARK: - Text Color Palette Definition

/// Type containing text colors used all over the application.
public struct TextColors {
  // MARK: - Public Properties

  public let primary: Color
  public let secondary: Color
  public let positive: Color
  public let negative: Color
  public let disabled: Color
  public let inverted: Color

  // MARK: - Initializer

  public init(primary: Color, secondary: Color, positive: Color, negative: Color, disabled: Color, inverted: Color) {
    self.primary = primary
    self.secondary = secondary
    self.positive = positive
    self.negative = negative
    self.disabled = disabled
    self.inverted = inverted
  }
}
