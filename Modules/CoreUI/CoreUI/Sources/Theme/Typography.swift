//
//  Typography.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 31.08.2025.
//

import SwiftUI

// MARK: - Typography Definition

/// Type that contains all the fonts used by a specific theme of the application.
public struct Typography {
  // MARK: - Nested Types

  /// Theme's title fonts.
  public struct Title {
    /// Default size 28, line height 34.
    public let title1: BTFont
    /// Default size 22, line height 28.
    public let title2: BTFont
    /// Default size 20, line height 25.
    public let title3: BTFont
    /// Default size 17, line height 22.
    public let headline: BTFont

    public init(title1: BTFont, title2: BTFont, title3: BTFont, headline: BTFont) {
      self.title1 = title1
      self.title2 = title2
      self.title3 = title3
      self.headline = headline
    }
  }

  /// Theme's body fonts.
  public struct Body {
    /// Default size 17, line height 22.
    public let body: BTFont
    /// Default size 17, line height 22, bold.
    public let bodyBold: BTFont
    /// Default size 15, line height 20.
    public let subheadline: BTFont
    /// Default size 15, line height 20, bold.
    public let subheadlineBold: BTFont
    /// Default size 13, line height 18.
    public let footnote: BTFont
    /// Default size 13, line height 18, bold.
    public let footnoteBold: BTFont

    public init(
      body: BTFont,
      bodyBold: BTFont,
      subheadline: BTFont,
      subheadlineBold: BTFont,
      footnote: BTFont,
      footnoteBold: BTFont
    ) {
      self.body = body
      self.bodyBold = bodyBold
      self.subheadline = subheadline
      self.subheadlineBold = subheadlineBold
      self.footnote = footnote
      self.footnoteBold = footnoteBold
    }
  }

  /// Theme's caption fonts.
  public struct Caption {
    /// Default size 12, line height 16.
    public let caption1: BTFont
    /// Default size 12, line height 16, bold.
    public let caption1Bold: BTFont
    /// Default size 11, line height 13.
    public let caption2: BTFont
    /// Default size 11, line height 13, bold.
    public let caption2Bold: BTFont

    public init(caption1: BTFont, caption1Bold: BTFont, caption2: BTFont, caption2Bold: BTFont) {
      self.caption1 = caption1
      self.caption1Bold = caption1Bold
      self.caption2 = caption2
      self.caption2Bold = caption2Bold
    }
  }

  // MARK: - Public Properties

  /// Theme's title fonts.
  public let title: Title
  /// Theme's body fonts.
  public let body: Body
  /// Theme's caption fonts.
  public let caption: Caption

  // MARK: - Lifecycle

  public init(title: Title, body: Body, caption: Caption) {
    self.title = title
    self.body = body
    self.caption = caption
  }
}
