//
//  ShimmerCatalog.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 22.09.2025.
//

import SwiftUI

/// Type containing shimmer effect colors used all over the application.
public struct ShimmerCatalog {
  public let baseColor: Color
  public let highlightColor: Color
  public let baseColorOpacity: CGFloat
  public let highlightColorOpacity: CGFloat

  public init(
    baseColor: Color,
    highlightColor: Color,
    baseColorOpacity: CGFloat,
    highlightColorOpacity: CGFloat
  ) {
    self.baseColor = baseColor
    self.highlightColor = highlightColor
    self.baseColorOpacity = baseColorOpacity
    self.highlightColorOpacity = highlightColorOpacity
  }
}
