//
//  ProgressBar.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 23/08/2026.
//

import SwiftUI

/// UI component capable of displaying a progress bar of the given type.
public struct ProgressBar: View {
  // MARK: - Nested Types

  @frozen
  public enum Style {
    case `default`
  }

  private enum Constants {
    static let defaultMaximumValue: CGFloat = 1
  }

  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - State Properties

  @Binding private var progress: CGFloat

  // MARK: - Private Properties

  private let style: Style
  private let total: CGFloat

  // MARK: - Computed Properties

  private var progressColor: Color {
    switch style {
    case .default:
      theme.colorPalette.tint.primary
    }
  }

  // MARK: - Initializer

  /// Initializes a new ``ProgressBar``.
  /// - Parameters:
  ///   - progress: The current level of progress.
  ///   - style: The style of slider.
  ///   - total: The maximum value which is represented on the slider.
  public init(
    progress: Binding<CGFloat>,
    style: Style = .default,
    total: CGFloat? = nil
  ) {
    self._progress = progress
    self.style = style
    self.total = total ?? Constants.defaultMaximumValue
  }

  // MARK: - Body

  public var body: some View {
    if isLoading {
      loadingView
    } else {
      loadedView
    }
  }

  // MARK: - Loading View

  private var loadingView: some View {
    ProgressView(value: total, total: total)
      .redacted(reason: .placeholder)
      .shimmer(style: ShimmerStyle(theme: theme), active: true)
  }

  // MARK: - Loaded View

  private var loadedView: some View {
    ProgressView(value: progress, total: total)
      .tint(progressColor)
  }
}
