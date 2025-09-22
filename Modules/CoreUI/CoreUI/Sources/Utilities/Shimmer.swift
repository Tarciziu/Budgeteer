//
//  Shimmer.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 22.09.2025.
//

import SwiftUI

/// A view modifier that applies a shimmer effect to the modified view.
/// https://medium.com/@rishixcode/shimmer-effect-in-swiftui-a0d0a1dd586a
public struct Shimmer: ViewModifier {
  // MARK: - Private Properties

  @State private var phase: CGFloat
  private var style: ShimmerStyle
  private let gradient: LinearGradient

  // MARK: - Initializer

  init(style: ShimmerStyle) {
    self.style = style
    self.gradient = LinearGradient(
      colors: [style.baseColor, style.highlightColor],
      startPoint: .leading,
      endPoint: .trailing
    )
    self.phase = .zero
  }

  // MARK: - Body

  public func body(content: Content) -> some View {
    content
      .backgroundStyle(gradient)
      .modifier(makeAnimatedMask())
      .task {
        withAnimation(
          Animation.linear(duration: style.duration).repeatForever(autoreverses: false)
        ) {
          phase = style.initialPhase
        }
      }
  }

  // MARK: - Private Methods

  private func makeAnimatedMask() -> AnimatedMask {
    AnimatedMask(
      phase: self.phase,
      centerColor: style.baseColor.opacity(style.baseColorOpacity),
      edgeColor: style.highlightColor.opacity(style.highlightColorOpacity),
      scaleEffect: style.scaleEffect
    )
  }
}

/// A view modifier that applies an animated mask to the modified view.
struct AnimatedMask: Animatable, ViewModifier {
  // MARK: - Properties

  var phase: CGFloat = .zero
  let centerColor: Color
  let edgeColor: Color
  let scaleEffect: CGFloat

  var animatableData: CGFloat {
    get { phase }
    set { phase = newValue }
  }

  // MARK: - Methods

  func body(content: Content) -> some View {
    content
      .mask {
        GradientMask(
          phase: phase,
          centerColor: centerColor,
          edgeColor: edgeColor
        )
        .scaleEffect(scaleEffect)
      }
  }
}

/// A view that represents a gradient mask used for the shimmer effect.
struct GradientMask: View {
  // MARK: - Nested Types

  private enum Constants {
    static let centerColorStepper: CGFloat = 0.1
    static let edgeColorStepper: CGFloat = 0.2
  }

  // MARK: - Properties

  let phase: CGFloat
  let centerColor: Color
  let edgeColor: Color
  let centerColorStepper: CGFloat = Constants.centerColorStepper
  let edgeColorStepper: CGFloat = Constants.edgeColorStepper
  let gradient: Gradient

  // MARK: - Initializer

  init(
    phase: CGFloat,
    centerColor: Color,
    edgeColor: Color
  ) {
    self.phase = phase
    self.centerColor = centerColor
    self.edgeColor = edgeColor
    self.gradient = Gradient(stops: [
      .init(color: edgeColor, location: phase),
      .init(color: centerColor, location: phase + centerColorStepper),
      .init(color: edgeColor, location: phase + edgeColorStepper)
    ])
  }

  // MARK: - Body

  var body: some View {
    LinearGradient(
      gradient: gradient,
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }
}

extension View {
  /// Applies a shimmer effect to the view.
  /// - Parameters:
  ///   - style: The style of the shimmer effect.
  ///   - active: A boolean value that determines whether the shimmer effect is active.
  /// - Returns: A view with the shimmer effect applied if active is true; otherwise, the original view.
  @ViewBuilder
  public func shimmer(style: ShimmerStyle, active: Bool = true) -> some View {
    if active {
      modifier(Shimmer(style: style))
    } else {
      self
    }
  }
}

/// A struct representing the style of the shimmer effect.
public struct ShimmerStyle {
  // MARK: - Nested Types

  public enum Constants {
    public static let initialPhase = CGFloat(0.8)
    public static let duration = CFTimeInterval(1.5)
    public static let scaleEffect = CGFloat(3.0)
  }

  // MARK: - Properties

  var baseColor: Color
  var highlightColor: Color
  var baseColorOpacity: CGFloat
  var highlightColorOpacity: CGFloat
  var initialPhase: CGFloat
  var duration: CFTimeInterval
  var scaleEffect: CGFloat

  // MARK: - Initialization

  public init(
    baseColor: Color,
    highlightColor: Color,
    baseColorOpacity: CGFloat,
    highlightColorOpacity: CGFloat,
    initialPhase: CGFloat,
    duration: CFTimeInterval,
    scaleEffect: CGFloat
  ) {
    self.baseColor = baseColor
    self.highlightColor = highlightColor
    self.baseColorOpacity = baseColorOpacity
    self.highlightColorOpacity = highlightColorOpacity
    self.initialPhase = initialPhase
    self.duration = duration
    self.scaleEffect = scaleEffect
  }

  public init(
    theme: BTTheme,
    initialPhase: CGFloat = Constants.initialPhase,
    duration: CFTimeInterval = Constants.duration,
    scaleEffect: CGFloat = Constants.scaleEffect
  ) {
    self.init(
      baseColor: theme.shimmer.baseColor,
      highlightColor: theme.shimmer.highlightColor,
      baseColorOpacity: theme.shimmer.baseColorOpacity,
      highlightColorOpacity: theme.shimmer.highlightColorOpacity,
      initialPhase: initialPhase,
      duration: duration,
      scaleEffect: scaleEffect
    )
  }
}
