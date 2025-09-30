//
//  SectionHeader.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 29.09.2025.
//

import SwiftUI


/// Type representing a reusable UI component used as a section header.
public struct SectionHeader: View {
  // MARK: - Environment Properties

  @Environment(\.isLoading)
  private var isLoading

  @Environment(BTTheme.self)
  private var theme: BTTheme

  // MARK: - Private Properties

  private let content: Content

  // MARK: - Init

  /// Creates a new `SectionHeader`.
  /// - Parameter content: The content model of the component.
  public init(content: Content) {
    self.content = content
  }

  // MARK: - Body

  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      section
    }
    .redacted(reason: isLoading ? .placeholder : [])
    .shimmer(style: ShimmerStyle(theme: theme), active: isLoading)
  }

  // MARK: - Subviews

  private var section: some View {
    HStack {
      leadingContent
      Spacer()
    }
    .padding(.horizontal, theme.spacing.spacerL)
    .padding(.vertical, theme.spacing.spacerL)
  }

  private var leadingContent: some View {
    HStack(alignment: .center, spacing: theme.spacing.spacerM) {
      leadingIcon
      VStack(alignment: .leading, spacing: .zero) {
        title
        caption
      }
    }
    .backgroundStyle(theme.colorPalette.surface.primary)
  }

  private var title: some View {
    Text(content.title)
      .font(theme.typography.body.bodyBold)
      .foregroundStyle(theme.colorPalette.text.primary)
  }

  @ViewBuilder private var caption: some View {
    if let caption = content.caption {
      Text(caption)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  @ViewBuilder private var leadingIcon: some View {
    if let icon = content.icon {
      Image(systemName: icon)
        .resizable()
        .renderingMode(.template)
        .frame(width: theme.iconSize.iconXL, height: theme.iconSize.iconXL)
        .foregroundStyle(theme.colorPalette.bottomSheet.button)
    }
  }
}

extension SectionHeader {
  /// The content model of section header.
  public struct Content {
    let icon: String?
    let title: String
    let caption: String?

    /// Creates a new content model for the section header.
    /// - Parameters:
    ///   - icon: The icon displayed on the left side.
    ///   - title: The title displayed on the left.
    ///   - caption: The caption displayed below the title.
    public init(
      icon: String? = nil,
      title: String,
      caption: String? = nil
    ) {
      self.icon = icon
      self.title = title
      self.caption = caption
    }
  }
}
