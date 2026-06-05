//
//  CardButton.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 24.09.2025.
//

import SwiftUI

/// Type serving as a reusable component for a card button.
/// https://app.visily.ai/projects/a7ec36eb-a50d-4d81-8abf-b2c651567894/boards/2143621/elements/934120136
public struct CardButton: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme
  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let content: Content
  private let action: () -> Void

  // MARK: - Init

  /// Creates a new `CardButton`.
  /// - Parameters:
  ///   - content: The content model associated with the view.
  ///   - action: The action associated with the button.
  public init(content: Content, action: @escaping () -> Void) {
    self.content = content
    self.action = action
  }

  // MARK: - Body

  public var body: some View {
    Button {
      action()
    } label: {
      cardContent
    }
  }

  // MARK: - Subviews

  private var cardContent: some View {
    VStack(spacing: theme.spacing.spacerS) {
      icon
      text
    }
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
    .padding(theme.spacing.spacerXXL)
    .frame(maxWidth: .infinity)
    .background(theme.colorPalette.surface.primary)
    .clipShape(RoundedRectangle(cornerRadius: theme.borderRadius.radiusS))
    .overlay {
      borderView
    }
  }

  private var icon: some View {
    Image(systemName: content.icon)
      .resizable()
      .frame(width: theme.spacing.spacerXL, height: theme.spacing.spacerXL)
      .foregroundStyle(theme.colorPalette.icon.positive)
  }

  private var text: some View {
    Text(content.title)
      .foregroundStyle(theme.colorPalette.text.primary)
      .font(theme.typography.body.body)
  }

  @ViewBuilder private var borderView: some View {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusS)
      .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
  }
}

extension CardButton {
  /// The conttent model of the `CardButton`.
  public struct Content {
    let title: String
    let icon: String

    /// Creates a new content model for the `CardButton`.
    /// - Parameters:
    ///   - title: The text displayed on the button.
    ///   - icon: The icon displayed.
    public init(title: String, icon: String) {
      self.title = title
      self.icon = icon
    }
  }
}
