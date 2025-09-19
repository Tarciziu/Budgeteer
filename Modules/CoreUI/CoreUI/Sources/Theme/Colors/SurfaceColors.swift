//
//  SurfaceColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 16.09.2025.
//

import SwiftUI

// MARK: - Surface Color Palette Definition

/// Type containing surface colors used all over the application.
public struct SurfaceColors {
  // MARK: - Public Properties

  public let primary: Color
  public let secondary: Color
  public let secondaryPressed: Color
  public let light: Color
  public let dark: Color
  public let overlay: Color

  // MARK: - Initializer

  public init(
    primary: Color,
    secondary: Color,
    secondaryPressed: Color,
    light: Color,
    dark: Color,
    overlay: Color
  ) {
    self.primary = primary
    self.secondary = secondary
    self.secondaryPressed = secondaryPressed
    self.light = light
    self.dark = dark
    self.overlay = overlay
  }
}
