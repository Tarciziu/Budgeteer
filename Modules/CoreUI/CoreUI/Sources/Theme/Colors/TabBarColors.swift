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
  // MARK: - Nested Types

  public struct TabColors {
    // MARK: - Public Properties

    public let activeIcon: UIColor
    public let activeLabel: UIColor
    public let defaultIcon: UIColor
    public let defaultLabel: UIColor

    // MARK: - Initializer

    public init(
      activeIcon: UIColor,
      activeLabel: UIColor,
      defaultIcon: UIColor,
      defaultLabel: UIColor
    ) {
      self.activeIcon = activeIcon
      self.activeLabel = activeLabel
      self.defaultIcon = defaultIcon
      self.defaultLabel = defaultLabel
    }
  }

  // MARK: - Public Properties

  public let background: UIColor
  public let tab: TabColors

  // MARK: - Initializer

  public init(background: UIColor, tab: TabColors) {
    self.background = background
    self.tab = tab
  }
}
