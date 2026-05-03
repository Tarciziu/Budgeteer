//
//  ComponentsLibraryScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import SwiftUI
import BTCoreUI

struct ComponentsLibraryScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  private var viewModel: ComponentsLibraryViewModel

  // MARK: - Initializer

  init(viewModel: ComponentsLibraryViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        ForEach(viewModel.filteredComponents, id: \.self) { component in
          NavigationListCell(
            content: .init(
              icon: component.icon,
              title: component.title,
              caption: component.caption,
              navigationIcon: .default,
              hasDivider: component != viewModel.filteredComponents.last
            )
          ) {
            viewModel.navigate(to: component)
          }
        }
      }
      .background(theme.colorPalette.surface.primary)
      .clipShape(RoundedRectangle(cornerRadius: theme.borderRadius.radiusS))
      .overlay {
        RoundedRectangle(cornerRadius: theme.borderRadius.radiusS)
          .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .searchable(text: Bindable(viewModel).searchText, placement: .navigationBarDrawer(displayMode: .automatic))
    .navigationBar(NavigationBarConfiguration(title: "Components Library"))
  }
}
