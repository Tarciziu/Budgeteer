//
//  MainTheme.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 30.08.2025.
//

import SwiftUI
import BTCoreUI

// MARK: - Typography Definition

extension Typography {
  static let mainTypography = Typography(
    title: Title(
      title1: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 28, lineHeight: 34, textStyle: .title1),
      title2: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 22, lineHeight: 28, textStyle: .title2),
      title3: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 20, lineHeight: 25, textStyle: .title3),
      headline: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 17, lineHeight: 22, textStyle: .headline)
    ),
    body: Body(
      body: BTFont(fontName: "TimesNewRomanPSMT", size: 17, lineHeight: 22, textStyle: .body),
      bodyBold: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 17, lineHeight: 22, textStyle: .body),
      subheadline: BTFont(fontName: "TimesNewRomanPSMT", size: 15, lineHeight: 20, textStyle: .subheadline),
      subheadlineBold: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 15, lineHeight: 20, textStyle: .subheadline),
      footnote: BTFont(fontName: "TimesNewRomanPSMT", size: 13, lineHeight: 18, textStyle: .footnote),
      footnoteBold: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 13, lineHeight: 18, textStyle: .footnote)
    ),
    caption: Caption(
      caption1: BTFont(fontName: "TimesNewRomanPSMT", size: 12, lineHeight: 16, textStyle: .caption1),
      caption1Bold: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 12, lineHeight: 16, textStyle: .caption1),
      caption2: BTFont(fontName: "TimesNewRomanPSMT", size: 11, lineHeight: 13, textStyle: .caption2),
      caption2Bold: BTFont(fontName: "TimesNewRomanPS-BoldMT", size: 11, lineHeight: 13, textStyle: .caption2)
    )
  )
}

// MARK: - Spacing Definition

extension Spacing {
  static let mainSpacing = Spacing(
    lineWidth: 1.0,
    spacerXS: 4.0,
    spacerS: 8.0,
    spacerM: 12.0,
    spacerL: 16.0,
    spacerXL: 20.0,
    spacerXXL: 24.0
  )
}

// MARK: - IconSize Definition

extension IconSize {
  static let mainIconSize = IconSize(
    iconXXS: 10.0,
    iconXS: 14.0,
    iconS: 16.0,
    iconM: 18.0,
    iconL: 20.0,
    iconXL: 24.0,
    iconXXL: 32.0
  )
}
