//
//  ProfilePage.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2025.
//

import SwiftUI
import BTCoreUI

struct ProfilePage: View {
  // MARK: - Nested Type

  private enum Constants {
    // TODO: - Standardize i
    static let appearanceIcon = "paintbrush"
    static let fedbackIcon = "message"
    static let remindersFeedback = "bell"
    static let borderRadius: CGFloat = 6
  }

  // MARK: - Observed Properties

  @ObservedObject private var viewModel: ProfilePageViewModel
  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  private let navBarConfig: NavigationBarConfiguration

  // MARK: - Computed Properties

  private var uiModel: ProfilePageUIModel {
    viewModel.uiModel
  }

  // MARK: - Init

  init(
    viewModel: ProfilePageViewModel,
    config: NavigationBarConfiguration
  ) {
    self.navBarConfig = config
    self.viewModel = viewModel
  }

  // MARK: - Body

  var body: some View {
    ScrollView(showsIndicators: false) {
      ForEach(uiModel.sections.indices, id: \.self) { index in
        VStack(spacing: theme.spacing.spacerL) {
          let section = uiModel.sections[index]
          makeSection(with: section)
            .glassEffect(.regular, in: roundingShape)
            .padding(.horizontal, theme.spacing.spacerXXL)
        }
      }
    }
    .navigationBar(navBarConfig)
  }

  // MARK: - Subviews

  @ViewBuilder
  private func makeSection(
    with sectionContent: ProfilePageUIModel.Section
  ) -> some View {
    VStack(spacing: .zero) {
      makeSectionHeader(with: sectionContent.title, and: sectionContent.subtitle, of: sectionContent.type)
      let links = sectionContent.links.map(\.self)
      makeLinksList(links: links, in: sectionContent.type)
    }
    .backgroundStyle(theme.colorPalette.surface.primary)
    .clipShape(roundingShape)
    .overlay {
      borderView
    }
  }

  private func makeSectionHeader(
    with title: String,
    and subtitle: String?,
    of type: ProfilePageUIModel.SectionType
  ) -> some View {
    // TODO: - Replce with dedicated section header component
    // Design seem to need a variant of this where the title is bolded.
    NavigationListCell(
      content: .init(
        icon: getSectionIcon(for: type),
        title: title,
        caption: subtitle,
        navigationIcon: .none,
        hasDivider: true
      )
    )
  }

  @ViewBuilder
  private func makeLinksList(
    links: [ProfilePageUIModel.Link],
    in sectionType: ProfilePageUIModel.SectionType
  ) -> some View {
    VStack(spacing: .zero) {
      ForEach(links.indices, id: \.self) { index in
        let link = links[index]
        NavigationListCell(
          content: .init(
            icon: getLinkIcon(for: link.type),
            title: link.title,
            caption: link.subtitle,
            navigationIcon: .default,
            hasDivider: index != links.count - 1
          )
        ) {
          // TODO: - Add Option
        }
      }
    }
  }

  private var roundingShape: some Shape {
    RoundedRectangle(cornerRadius: Constants.borderRadius)
  }

  @ViewBuilder private var borderView: some View {
    roundingShape
      .stroke(theme.colorPalette.icon.disabled, lineWidth: theme.spacing.lineWidth)
  }

  // MARK: - Private Methods

  private func getSectionIcon(for sectionType: ProfilePageUIModel.SectionType) -> String {
    switch sectionType {
    case .feedback:
      return Constants.fedbackIcon
    case .reminders:
      return Constants.remindersFeedback
    case .appearance:
      return Constants.appearanceIcon
    }
  }

  private func getLinkIcon(for linkType: ProfilePageUIModel.LinkType) -> String {
    switch linkType {
    case .suggestion:
      return Constants.fedbackIcon
    case .remindersConfiguration:
      return Constants.remindersFeedback
    case .theming:
      return Constants.appearanceIcon
    }
  }
}
