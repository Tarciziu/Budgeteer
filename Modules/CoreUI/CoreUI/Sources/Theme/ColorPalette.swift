//
//  ColorPalette.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 16.09.2025.
//

import Foundation

/// Type containing the colors used for a specific theme of the application.
public struct ColorPalette {
  // MARK: - Public Properties

  public let surface: SurfaceColors
  public let tint: TintColors
  public let tabBar: TabBarColors
  public let navigationBar: NavigationBarColors
  public let bottomSheet: BottomSheetColors
  public let text: TextColors
  public let icon: IconColors
  public let border: BorderColors

  // MARK: - Initializer

  public init(
    surface: SurfaceColors,
    tint: TintColors,
    tabBar: TabBarColors,
    navigationBar: NavigationBarColors,
    bottomSheet: BottomSheetColors,
    text: TextColors,
    icon: IconColors,
    border: BorderColors
  ) {
    self.surface = surface
    self.tint = tint
    self.tabBar = tabBar
    self.navigationBar = navigationBar
    self.bottomSheet = bottomSheet
    self.text = text
    self.icon = icon
    self.border = border
  }
}
