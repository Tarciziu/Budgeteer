//
//  ValueListCell.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 24.09.2025.
//

import SwiftUI

/// Type representing a reusable UI component destined for displaying elements of a list.
public struct ValueListCell: View {
  // MARK: - Environment Properties

  @Environment(\.isLoading)
  private var isLoading

  @Environment(BTTheme.self)
  private var theme: BTTheme

  // MARK: - Private Properties

  private let content: Content
  private let action: (() -> Void)?

  // MARK: - Init

  /// Creates a new `ValueListCell`.
  /// - Parameter content: The content model of the component.
  /// - Parameter action: Custom action to be executed When tapping on the list cell.
  public init(content: Content, action: (() -> Void)? = nil) {
    self.content = content
    self.action = action
  }

  // MARK: - Body

  public var body: some View {
    if let action {
      makeListCell(with: action)
    } else {
      listCellWithoutAction
    }
  }

  // MARK: - Subviews

  @ViewBuilder
  private func makeListCell(with action: @escaping () -> Void) -> some View {
    Button {
      action()
    } label: {
      listCellWithoutAction
    }
  }

  private var listCellWithoutAction: some View {
    HStack(alignment: .center, spacing: .zero) {
      leadingContent
      Spacer()
      trailingContent
    }
    .padding(theme.spacing.spacerL)
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
  }

  private var leadingContent: some View {
    HStack(alignment: .center, spacing: theme.spacing.spacerM) {
      if let avatar = content.leadingContent.avatar {
        avatar
      }
      VStack(alignment: .leading, spacing: .zero) {
        leadingTitle
        leadingCaption
      }
    }
    .backgroundStyle(theme.colorPalette.surface.primary)
  }

  private var leadingTitle: some View {
    Text(content.leadingContent.title)
      .font(theme.typography.body.body)
      .foregroundStyle(theme.colorPalette.text.primary)
  }

  @ViewBuilder private var leadingCaption: some View {
    if let caption = content.leadingContent.caption {
      Text(caption)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  @ViewBuilder private var trailingContent: some View {
    if let trailingContent = content.trailingContent {
      VStack(alignment: .trailing, spacing: .zero) {
        makeTrailingText(from: trailingContent.title, state: trailingContent.titleState)
        makeTrailingCaption(from: trailingContent.caption)
      }
    }
  }

  private func makeTrailingText(from title: String, state: LabelState) -> some View {
    Text(title)
      .font(theme.typography.body.body)
      .foregroundStyle(makeColor(from: state))
  }

  @ViewBuilder
  private func makeTrailingCaption(from caption: String?) -> some View {
    if let caption {
      Text(caption)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  // MARK: - Helper Methods

  private func makeColor(from state: LabelState) -> Color {
    return switch state {
    case .neutral:
      theme.colorPalette.text.primary
    case .positive:
      theme.colorPalette.text.positive
    case .negative:
      theme.colorPalette.text.negative
    }
  }
}

extension ValueListCell {
  public enum LabelState {
    case neutral
    case positive
    case negative
  }

  /// The trailing content model of the list cell.
  public struct TrailingContent {
    let title: String
    let titleState: LabelState
    let caption: String?

    /// Initializes a new instance of `TrailingContent`.
    /// - Parameters:
    ///   - title: The title of the trailing content.
    ///   - titleState: The state of the title, which can affect its appearance (e.g., color).
    ///   - caption: Optional caption displayed below the title.
    public init(
      title: String,
      titleState: LabelState = .neutral,
      caption: String? = nil
    ) {
      self.title = title
      self.titleState = titleState
      self.caption = caption
    }
  }

  /// The leading content model of the list cell.
  public struct LeadingContent {
    let avatar: Avatar?
    let title: String
    let caption: String?

    /// Creates a new content model for a navigation list cell.
    /// - Parameters:
    ///   - avatar: Optional ``Avatar`` displayed on the left side of the list cell.
    ///   - title: The title displayed on the left.
    ///   - caption: The caption displayed below the title.
    public init(
      avatar: Avatar? = nil,
      title: String,
      caption: String? = nil
    ) {
      self.avatar = avatar
      self.title = title
      self.caption = caption
    }
  }

  /// The main content model of the list cell.
  public struct Content {
    let leadingContent: LeadingContent
    let trailingContent: TrailingContent?

    /// Creates a new content model for a navigation list cell.
    /// - Parameters:
    ///   - leadingContent: The leading content of the list cell.
    ///   - trailingContent: Optional ``TrailingContent`` representing the trailing content of the list cell, such as additional information or actions displayed on the right side.
    public init(
      leadingContent: LeadingContent,
      trailingContent: TrailingContent? = nil
    ) {
      self.leadingContent = leadingContent
      self.trailingContent = trailingContent
    }
  }
}
