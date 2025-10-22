//
//  BorderColors.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 21.10.2025.
//

import SwiftUI

/// A structure representing various border colors used throughout the application.
public struct BorderColors {
  // MARK: - Public Properties

  /// The primary border color.
  public let primary: Color

  // MARK: - Initializer

  /// Initializes a new instance of `BorderColors`.
  /// - Parameter primary: The primary border color as a string.
  public init(primary: Color) {
    self.primary = primary
  }
}
