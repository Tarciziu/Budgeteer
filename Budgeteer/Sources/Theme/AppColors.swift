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
      primary: Color("neutral-000"),
      secondary: Color("neutral-transparent-1"),
      secondaryPressed: Color("neutral-200"),
      light: Color("neutral-100"),
      dark: Color("neutral-900"),
      overlay: Color("neutral-transparent-2"),
      disabled: Color("neutral-300"),
      inverted: Color("neutral-1000")
    )
  }

  private static func makeTabBarColors() -> TabBarColors {
    let tabColors = TabBarColors.TabColors(
      activeIcon: UIColor(named: "primary-400") ?? .systemBlue,
      activeLabel: UIColor(named: "primary-400") ?? .systemBlue,
      defaultIcon: UIColor(named: "neutral-900") ?? .black,
      defaultLabel: UIColor(named: "neutral-900") ?? .black
    )

    return TabBarColors(
      background: UIColor(named: "neutral-100") ?? .systemBackground,
      tab: tabColors
    )
  }

  private static func makeNavigationBarColors() -> NavigationBarColors {
    NavigationBarColors(
      surface: Color("neutral-000"),
      text: Color("neutral-900"),
      caption: Color("neutral-900"),
      icon: Color("neutral-900"),
      textUIColor: UIColor(named: "neutral-900") ?? .black,
      surfaceUIColor: UIColor(named: "neutral-000") ?? .black,
      iconUIColor: UIColor(named: "neutral-900") ?? .black
    )
  }

  private static func makeBottomSheetColors() -> BottomSheetColors {
    BottomSheetColors(
      surface: Color("sheetBackground"),
      title: Color("neutral-900"),
      caption: Color("neutral-600"),
      icon: Color("neutral-600"),
      button: Color("primary-400"),
      closeSurface: Color("neutral-100"),
      closeIcon: Color("neutral-600")
    )
  }

  private static func makeTextColors() -> TextColors {
    TextColors(
      primary: Color("neutral-900"),
      secondary: Color("neutral-600"),
      positive: Color("positive-100"),
      negative: Color("negative-100"),
      disabled: Color("neutral-transparent-2"),
      inverted: Color("neutral-100")
    )
  }

  private static func makeIconColors() -> IconColors {
    IconColors(
      primary: Color("neutral-900"),
      secondary: Color("neutral-600"),
      positive: Color("positive-100"),
      negative: Color("negative-100"),
      disabled: Color("neutral-300")
    )
  }

  private static func makeBorderColors() -> BorderColors {
    BorderColors(
      primary: Color("neutral-300")
    )
  }
}
