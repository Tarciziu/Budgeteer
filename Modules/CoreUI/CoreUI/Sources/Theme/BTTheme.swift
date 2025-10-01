//
//  BTTheme.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 03.09.2025.
//

import Foundation

// MARK: - BTTheme Definition

/// The main theme structure that holds various design tokens and styles used throughout the application.
@Observable
public class BTTheme {
  // MARK: - Theme Components

  /// The currently used typography inside the application.
  public var typography: Typography

  /// The currently used color palette inside the application.
  public var spacing: Spacing

  /// The currently used icon sizes inside the application.
  public var iconSize: IconSize

  /// The currently used color palette inside the application.
  public var colorPalette: ColorPalette

  /// The currently used image catalog inside the application.
  public var imageCatalog: ImageCatalog

  /// The currently used shimmer catalog inside the application.
  public var shimmer: ShimmerCatalog

  /// The currently used border radius styles inside the application.
  public var borderRadius: BorderRadius

  // MARK: - Lifecycle

  public init(
    typography: Typography,
    spacing: Spacing,
    iconSize: IconSize,
    colorPalette: ColorPalette,
    imageCatalog: ImageCatalog,
    shimmer: ShimmerCatalog,
    borderRadius: BorderRadius
  ) {
    self.typography = typography
    self.spacing = spacing
    self.iconSize = iconSize
    self.colorPalette = colorPalette
    self.imageCatalog = imageCatalog
    self.shimmer = shimmer
    self.borderRadius = borderRadius
  }
}
