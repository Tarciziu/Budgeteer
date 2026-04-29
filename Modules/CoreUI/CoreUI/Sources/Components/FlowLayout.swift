//
//  FlowLayout.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 29/04/2026.
//

import SwiftUI

/// A layout that arranges its children horizontally, wrapping to the next row when the available width is exceeded.
public struct FlowLayout: Layout {
  // MARK: - Properties

  private let horizontalSpacing: CGFloat
  private let verticalSpacing: CGFloat

  // MARK: - Initializer

  /// Creates a new flow layout.
  /// - Parameters:
  ///   - horizontalSpacing: The horizontal spacing between items.
  ///   - verticalSpacing: The vertical spacing between rows.
  public init(horizontalSpacing: CGFloat = .zero, verticalSpacing: CGFloat = .zero) {
    self.horizontalSpacing = horizontalSpacing
    self.verticalSpacing = verticalSpacing
  }

  // MARK: - Layout

  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    arrange(in: proposal.width ?? .infinity, subviews: subviews).size
  }

  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    let result = arrange(in: bounds.width, subviews: subviews)
    for (index, position) in result.positions.enumerated() {
      subviews[index].place(
        at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
        proposal: .unspecified
      )
    }
  }

  // MARK: - Private Methods

  private func arrange(in maxWidth: CGFloat, subviews: Subviews) -> ArrangementResult {
    var positions: [CGPoint] = []
    var currentX: CGFloat = .zero
    var currentY: CGFloat = .zero
    var rowHeight: CGFloat = .zero
    var totalWidth: CGFloat = .zero

    for subview in subviews {
      let size = subview.sizeThatFits(.unspecified)
      if currentX + size.width > maxWidth, currentX > .zero {
        currentX = .zero
        currentY += rowHeight + verticalSpacing
        rowHeight = .zero
      }
      positions.append(CGPoint(x: currentX, y: currentY))
      rowHeight = max(rowHeight, size.height)
      currentX += size.width + horizontalSpacing
      totalWidth = max(totalWidth, currentX - horizontalSpacing)
    }

    return ArrangementResult(
      positions: positions,
      size: CGSize(width: totalWidth, height: currentY + rowHeight)
    )
  }
}

// MARK: - Arrangement Result

extension FlowLayout {
  private struct ArrangementResult {
    let positions: [CGPoint]
    let size: CGSize
  }
}
