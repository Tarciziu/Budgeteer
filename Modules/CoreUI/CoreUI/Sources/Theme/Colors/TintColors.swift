//
//  TintColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 19.09.2025.
//

import SwiftUI

// MARK: - Tint Color Palette Definition

/// A structure representing the brand tint colors used throughout the application.
public struct TintColors {
  // MARK: - Public Properties

  /// The primary tint color, used for interactive elements, links, and brand accents.
  public let primary: Color

  // MARK: - Initializer

  public init(primary: Color) {
    self.primary = primary
  }
}
