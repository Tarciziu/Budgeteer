//
//  BTFont.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 31.08.2025.
//

import SwiftUI
import UIKit

/// A custom font with a specific line height.
/// This struct encapsulates a `UIFont` and its associated line height,
/// allowing for consistent text styling throughout the app.
public struct BTFont {
  public let font: UIFont
  let lineHeight: CGFloat

  public init(fontName: String, size: CGFloat, lineHeight: CGFloat, textStyle: UIFont.TextStyle) {
    let customFont = UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
    self.lineHeight = lineHeight
  }
}

// MARK: - Font with line height modifier

/// Solution found here: https://stackoverflow.com/questions/61705184/how-to-set-line-height-for-a-single-line-text-in-swiftui.
struct FontWithLineHeight: ViewModifier {
  let btFont: BTFont

  func body(content: Content) -> some View {
    let heightDifference = btFont.lineHeight - btFont.font.lineHeight
    let spacing: CGFloat = max(heightDifference, .zero)
    let padding = max(heightDifference / 2, .zero)
    return content
      .font(Font(btFont.font))
      .padding(.vertical, padding)
      .lineSpacing(spacing)
  }
}

extension Text {
  /// Applies a custom font with a specific line height to the text.
  /// - Parameter btFont: The custom font and line height to apply.
  /// - Returns: A text view with the specified font and line height.
  public func font(_ btFont: BTFont) -> some View {
    ModifiedContent(content: self, modifier: FontWithLineHeight(btFont: btFont))
  }
}

// MARK: - BTFont applier

struct BTFontApplier: ViewModifier {
  let btFont: BTFont

  func body(content: Content) -> some View {
    content.font(Font(btFont.font))
  }
}

extension View {
  /// Applies a custom font with a specific line height to the view.
  /// - Parameter btFont: The custom font and line height to apply.
  /// - Returns: A view with the specified font and line height.
  public func font(_ btFont: BTFont) -> some View {
    ModifiedContent(content: self, modifier: BTFontApplier(btFont: btFont))
  }
}
