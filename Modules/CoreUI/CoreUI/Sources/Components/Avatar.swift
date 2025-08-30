//
//  Avatar.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 30.08.2025.
//

import SwiftUI

/// UI component capable of displaying either an image or text inside a shape.
public struct Avatar: View {
  // MARK: - Nested Types

  /// Type of the content of the avatar.
  public enum ContentType {
    /// A type for avatar with one or two letters text center aligned.
    case text(String)
    /// A type for avatar with an image from assets.
    case image(String)
    /// A type for avatar with a system image.
    case systemImage(String)
  }

  /// Type defining the size of the avatar.
  public enum Size {
    case large
    case small
  }

  public enum AvatarShape: Shape {
    case circle
    case square

    public func path(in rect: CGRect) -> Path {
      switch self {
      case .circle:
        return Circle().path(in: rect)
      case .square:
        return RoundedRectangle(cornerRadius: Constants.cornerRadius).path(in: rect)
      }
    }
  }

  private enum Constants {
    static let largeAvatarDimension = 48.0
    static let smallAvatarDimension = 24.0
    static let cornerRadius = 8.0
    static let maximumNumberOfCharacters = 1
    static let placeholderDuration = 1.0
    // TODO: Replace with design system values (from spacing catalog)
    static let lineWidth = 1.0
  }

  // MARK: - Environment Object

  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let content: ContentType
  private let size: Size
  private let shape: AvatarShape
  private let hasBorder: Bool
  private let backgroundColor: Color?

  // MARK: - Computed Properties

  private var avatarDimension: CGFloat {
    switch size {
    case .large:
      return Constants.largeAvatarDimension
    case .small:
      return Constants.smallAvatarDimension
    }
  }

  // MARK: - Lifecycle

  /// Creates an avatar with the specified content.
  /// - Parameters:
  ///   - content: Content to be displayed.
  ///   - size: The size of the avatar.
  ///   - shape: The shape of the avatar.
  ///   - hasBorder: Boolean representing if the avatar has border or not.
  ///   - backgroundColor: Color used as background color. If `nil` a default color will be used.
  public init(
    content: ContentType,
    size: Size,
    shape: AvatarShape,
    hasBorder: Bool,
    backgroundColor: Color? = nil
  ) {
    self.content = content
    self.size = size
    self.shape = shape
    self.hasBorder = hasBorder
    self.backgroundColor = backgroundColor
  }

  // MARK: - View conformation

  public var body: some View {
    shape
    // TODO: Update default background color to match design system
      .foregroundStyle(backgroundColor ?? .gray.opacity(0.1))
      .frame(width: avatarDimension, height: avatarDimension)
      .overlay {
        contentView
          .if(isLoading) { view in
            view
            // TODO: update colors for gradient
              .foregroundStyle(
                .linearGradient(
                  colors: [.black.opacity(0.1), .black.opacity(0.9)],
                  startPoint: .leading,
                  endPoint: .trailing
                )
              )
          }
          .redacted(reason: .placeholder)
          .animation(
            .linear(
              duration: Constants.placeholderDuration
            ).repeatForever(autoreverses: false),
            value: isLoading
          )
      }
      .if(hasBorder) { view in
        view
          .overlay(borderView)
      }
  }

  // MARK: - Subviews

  @ViewBuilder private var contentView: some View {
    switch content {
    case .text(let text):
      makeTextView(text)
    case .image(let imageName):
      makeImageView(imageName)
    case .systemImage(let imageName):
      makeSystemImageView(imageName)
    }
  }

  // TODO: Update stroke values when catalogs are defined.
  @ViewBuilder private var borderView: some View {
    switch shape {
    case .circle:
      Circle()
        .stroke(.black, lineWidth: Constants.lineWidth)
    case .square:
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .stroke(.black, lineWidth: Constants.lineWidth)
    }
  }

  // MARK: - Private Methods

  // TODO: Update typography and color when design system is defined.
  private func makeTextView(_ text: String) -> some View {
    Text(text.prefix(Constants.maximumNumberOfCharacters).uppercased())
      .font(size == .large ? .headline : .subheadline)
      .foregroundStyle(.black)
  }

  private func makeImageView(_ imageName: String) -> some View {
    Image(imageName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: avatarDimension, height: avatarDimension)
      .clipShape(shape)
  }

  private func makeSystemImageView(_ imageName: String) -> some View {
    Image(systemName: imageName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: avatarDimension, height: avatarDimension)
      .clipShape(shape)
  }
}
