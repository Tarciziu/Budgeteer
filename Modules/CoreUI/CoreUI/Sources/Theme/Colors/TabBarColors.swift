//
//  TabBarColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 19.09.2025.
//

import SwiftUI

// MARK: - Tab Bar Color Palette Definition

/// Type containing tab bar colors used all over the application.
public struct TabBarColors {
  // MARK: - Public Properties

  public let background: UIColor
  /// The color applied to both the icon and label of the selected tab.
  public let active: UIColor
  /// The color applied to both the icon and label of unselected tabs.
  public let `default`: UIColor

  // MARK: - Initializer

  public init(background: UIColor, active: UIColor, default defaultColor: UIColor) {
    self.background = background
    self.active = active
    self.default = defaultColor
  }
}
