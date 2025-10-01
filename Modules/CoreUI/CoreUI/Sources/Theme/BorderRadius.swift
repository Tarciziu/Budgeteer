//
//  BorderRadius.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import SwiftUI

/// Type containing border radius values used all over the application.
public struct BorderRadius {
  // MARK: - Public Properties

  /// Default value is `4.0`.
  public let radiusXS: CGFloat
  /// Default value is `6.0`.
  public let radiusS: CGFloat
  /// Default value is `8.0`.
  public let radiusM: CGFloat
  /// Default value is `12.0`.
  public let radiusL: CGFloat
  /// Default value is `16.0`.
  public let radiusXL: CGFloat
  /// Default value is `24.0`.
  public let radiusXXL: CGFloat

  // MARK: - Initializer

  public init(
    radiusXS: CGFloat,
    radiusS: CGFloat,
    radiusM: CGFloat,
    radiusL: CGFloat,
    radiusXL: CGFloat,
    radiusXXL: CGFloat
  ) {
    self.radiusXS = radiusXS
    self.radiusS = radiusS
    self.radiusM = radiusM
    self.radiusL = radiusL
    self.radiusXL = radiusXL
    self.radiusXXL = radiusXXL
  }
}
