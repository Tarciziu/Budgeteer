//
//  Spacing.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 30.08.2025.
//

import SwiftUI

/// Type containing all values for a specific theme in the application.
public struct Spacing {
  /// Default value is `1.0`.
  public let lineWidth: CGFloat
  /// Default value is `4.0`.
  public let spacerXS: CGFloat
  /// Default value is `8.0`.
  public let spacerS: CGFloat
  /// Default value is `12.0`.
  public let spacerM: CGFloat
  /// Default value is `16.0`.
  public let spacerL: CGFloat
  /// Default value is `20.0`.
  public let spacerXL: CGFloat
  /// Default value is `24.0`.
  public let spacerXXL: CGFloat

  /// Initializes a new instance of the spacing catalog.
  /// - Parameters:
  ///   - lineWidth: Width of a line.
  ///   - spacerXS: Extra small space.
  ///   - spacerS: Small space.
  ///   - spacerM: Medium space.
  ///   - spacerL: Large space.
  ///   - spacerXL: Extra large space.
  ///   - spacerXXL: Extra-extra large space.
  public init(
    lineWidth: CGFloat,
    spacerXS: CGFloat,
    spacerS: CGFloat,
    spacerM: CGFloat,
    spacerL: CGFloat,
    spacerXL: CGFloat,
    spacerXXL: CGFloat
  ) {
    self.lineWidth = lineWidth
    self.spacerXS = spacerXS
    self.spacerS = spacerS
    self.spacerM = spacerM
    self.spacerL = spacerL
    self.spacerXL = spacerXL
    self.spacerXXL = spacerXXL
  }
}
