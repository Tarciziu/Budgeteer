//
//  BottomSheetColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 19.09.2025.
//

import SwiftUI

// MARK: - Bottom Sheet Color Palette Definition

///  Type containing sheet colors used all over the application.
public struct BottomSheetColors {
  // MARK: - Public Properties

  public let surface: Color
  public let title: Color
  public let caption: Color
  public let icon: Color
  public let button: Color
  public let closeSurface: Color
  public let closeIcon: Color

  // MARK: - Initializer

  public init(
    surface: Color,
    title: Color,
    caption: Color,
    icon: Color,
    button: Color,
    closeSurface: Color,
    closeIcon: Color
  ) {
    self.surface = surface
    self.title = title
    self.caption = caption
    self.icon = icon
    self.button = button
    self.closeSurface = closeSurface
    self.closeIcon = closeIcon
  }
}
