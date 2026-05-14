//
//  ColorPalette.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 19.09.2025.
//

import SwiftUI
import BTCoreUI

extension ColorPalette {
  static let appColorPalette: ColorPalette = {
    ColorPalette(
      surface: makeSurfaceColors(),
      tint: makeTintColors(),
      tabBar: makeTabBarColors(),
      navigationBar: makeNavigationBarColors(),
      bottomSheet: makeBottomSheetColors(),
      text: makeTextColors(),
      icon: makeIconColors(),
      border: makeBorderColors()
    )
  }()
}

extension ColorPalette {
  private static func makeSurfaceColors() -> SurfaceColors {
    SurfaceColors(
      primary: Color("surface-primary"),
      secondary: Color("surface-secondary"),
      secondaryPressed: Color("surface-secondary-pressed"),
      light: Color("surface-light"),
      dark: Color("surface-dark"),
      overlay: Color("surface-overlay"),
      disabled: Color("surface-disabled"),
      inverted: Color("surface-inverted")
    )
  }

  private static func makeTintColors() -> TintColors {
    TintColors(
      primary: Color("tint-primary")
    )
  }

  private static func makeTabBarColors() -> TabBarColors {
    TabBarColors(
      background: UIColor(named: "tab-bar-background") ?? .systemBackground,
      active: UIColor(named: "tab-bar-active") ?? .systemBlue,
      default: UIColor(named: "tab-bar-default") ?? .black
    )
  }

  private static func makeNavigationBarColors() -> NavigationBarColors {
    NavigationBarColors(
      surface: Color("nav-bar-surface"),
      text: Color("nav-bar-text"),
      icon: Color("nav-bar-icon"),
      textUIColor: UIColor(named: "nav-bar-text") ?? .black,
      surfaceUIColor: UIColor(named: "nav-bar-surface") ?? .systemBackground,
      iconUIColor: UIColor(named: "nav-bar-icon") ?? .black
    )
  }

  private static func makeBottomSheetColors() -> BottomSheetColors {
    BottomSheetColors(
      surface: Color("sheet-surface"),
      title: Color("sheet-title"),
      caption: Color("sheet-caption"),
      icon: Color("sheet-icon"),
      button: Color("sheet-button"),
      closeSurface: Color("sheet-close-surface"),
      closeIcon: Color("sheet-close-icon")
    )
  }

  private static func makeTextColors() -> TextColors {
    TextColors(
      primary: Color("text-primary"),
      secondary: Color("text-secondary"),
      positive: Color("text-positive"),
      negative: Color("text-negative"),
      disabled: Color("text-disabled"),
      inverted: Color("text-inverted")
    )
  }

  private static func makeIconColors() -> IconColors {
    IconColors(
      primary: Color("icon-primary"),
      secondary: Color("icon-secondary"),
      positive: Color("icon-positive"),
      negative: Color("icon-negative"),
      disabled: Color("icon-disabled")
    )
  }

  private static func makeBorderColors() -> BorderColors {
    BorderColors(
      primary: Color("border-primary"),
      negative: Color("border-negative")
    )
  }
}
