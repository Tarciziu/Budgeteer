//
//  DeveloperMenu.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11.09.2025.
//

import SwiftUI
import BTCoreUI

/// Container used to display the developer menu
struct DeveloperMenu: View {
  // MARK: - Nested Types

  private enum Constants {
    static let title = "Developer Menu"
  }

  // MARK: - Observed Properties

  @Environment(BTTheme.self)
  private var theme
  private var viewModel: DeveloperMenuViewModel

  // MARK: - Private Properties

  private var navigationConfiguration: NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(icon: theme.imageCatalog.uiAction.close) {
      viewModel.close()
    }
    return NavigationBarConfiguration(title: Constants.title, trailingAction: trailingAction)
  }

  // MARK: - Initializer

  init(viewModel: DeveloperMenuViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXL) {
        reusableViewsSection
        samplesSection
        developerOptionsSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(navigationConfiguration)
  }

  // MARK: - Reusable Views

  private var reusableViewsSection: some View {
    VStack(alignment: .leading, spacing: .zero) {
      SectionHeader(content: .init(icon: "puzzlepiece.extension", title: "Reusable Views"))
      NavigationListCell(
        content: .init(
          icon: "square.grid.2x2",
          title: "Components Library",
          caption: "Browse all reusable components",
          navigationIcon: .default
        )
      ) {
        viewModel.navigate(to: .componentsLibrary)
      }
    }
    .background(theme.colorPalette.surface.primary)
    .clipShape(RoundedRectangle(cornerRadius: theme.borderRadius.radiusS))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusS)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
  }

  // MARK: - Samples

  private var samplesSection: some View {
    VStack(alignment: .leading, spacing: .zero) {
      SectionHeader(content: .init(icon: "flask", title: "Samples", caption: "Coming Soon"))
    }
    .background(theme.colorPalette.surface.primary)
    .clipShape(RoundedRectangle(cornerRadius: theme.borderRadius.radiusS))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusS)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
  }

  // MARK: - Developer Options

  private var developerOptionsSection: some View {
    VStack(alignment: .leading, spacing: .zero) {
      SectionHeader(content: .init(icon: "wrench.and.screwdriver", title: "Developer Options", caption: "Coming Soon"))
    }
    .background(theme.colorPalette.surface.primary)
    .clipShape(RoundedRectangle(cornerRadius: theme.borderRadius.radiusS))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusS)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
  }
}
