//
//  NavigationBarColor.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 19.09.2025.
//

import SwiftUI

// MARK: - Navigation Bar Color Palette Definition

/// Type containing navigation bar colors used all over the application.
public struct NavigationBarColors {
  public let surface: Color
  public let text: Color
  public let icon: Color
  public let textUIColor: UIColor
  public let surfaceUIColor: UIColor
  public let iconUIColor: UIColor

  // MARK: - Initializer

  public init(
    surface: Color,
    text: Color,
    icon: Color,
    textUIColor: UIColor,
    surfaceUIColor: UIColor,
    iconUIColor: UIColor
  ) {
    self.surface = surface
    self.text = text
    self.icon = icon
    self.textUIColor = textUIColor
    self.surfaceUIColor = surfaceUIColor
    self.iconUIColor = iconUIColor
  }
}
