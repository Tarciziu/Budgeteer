//
//  NavigationListCell.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 15.09.2025.
//

import SwiftUI

/// Type representing a reusable UI component destined for navigation.
public struct NavigationListCell: View {
  // MARK: - Environment Properties

  @Environment(\.isLoading)
  private var isLoading

  @Environment(BTTheme.self)
  private var theme: BTTheme

  // MARK: - Private Properties

  private let content: Content
  private let action: (() -> Void)?

  // MARK: - Init

  /// Creates a new `NavigationListCell`.
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
      trailingIcon
    }
    .padding(.horizontal, theme.spacing.spacerL)
    .padding(.vertical, theme.spacing.spacerL)
    .redacted(reason: isLoading ? .placeholder : [])
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
      .font(theme.typography.body.body)
      .foregroundStyle(theme.colorPalette.text.primary)
  }

  @ViewBuilder private var caption: some View {
    if let caption = content.caption {
      Text(caption)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  @ViewBuilder private var trailingIcon: some View {
    switch content.navigationIcon {
    case .none:
      EmptyView()
    case .default:
      makeTrailingIcon(with: theme.imageCatalog.uiAction.chevronRight)
    case .custom(let icon):
      makeTrailingIcon(with: icon)
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

  private func makeTrailingIcon(with name: String) -> some View {
    Image(systemName: name)
      .resizable()
      .renderingMode(.template)
      .frame(width: theme.iconSize.iconL, height: theme.iconSize.iconL)
      .foregroundStyle(theme.colorPalette.icon.primary)
  }
}

extension NavigationListCell {
  /// Type representing the navigation icon displayed in the right side of the cell.
  public enum NavigationIconType {
    case none
    case `default`
    case custom(String)
  }

  /// The content model of the list cell.
  public struct Content {
    let icon: String?
    let title: String
    let caption: String?
    let navigationIcon: NavigationIconType

    /// Creates a new content model for a navigation list cell.
    /// - Parameters:
    ///   - icon: The icon displayed on the left side
    ///   - title: The title displayed on the left.
    ///   - caption: The caption displayed bellow the title.
    ///   - navigationIcon: The navigation Icon displayed the the end.
    public init(
      icon: String?,
      title: String,
      caption: String? = nil,
      navigationIcon: NavigationIconType
    ) {
      self.icon = icon
      self.title = title
      self.caption = caption
      self.navigationIcon = navigationIcon
    }
  }
}
