//
//  IconSize.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 10.09.2025.
//

import Foundation

// MARK: IconSize catalog Definition

/// A structure representing various icon sizes used throughout the application.
public struct IconSize {
  // MARK: - Public Properties

  /// Default value `10.0`.
  public let iconXXS: CGFloat
  /// Default value `14.0`.
  public let iconXS: CGFloat
  /// Default value `16.0`.
  public let iconS: CGFloat
  /// Default value `18.0`.
  public let iconM: CGFloat
  /// Default value `20.0`.
  public let iconL: CGFloat
  /// Default value `24.0`.
  public let iconXL: CGFloat
  /// Default value `32.0`.
  public let iconXXL: CGFloat

  // MARK: - Initializer

  public init(
    iconXXS: CGFloat,
    iconXS: CGFloat,
    iconS: CGFloat,
    iconM: CGFloat,
    iconL: CGFloat,
    iconXL: CGFloat,
    iconXXL: CGFloat
  ) {
    self.iconXXS = iconXXS
    self.iconXS = iconXS
    self.iconS = iconS
    self.iconM = iconM
    self.iconL = iconL
    self.iconXL = iconXL
    self.iconXXL = iconXXL
  }
}
