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

  private var viewModel: DeveloperMenuViewModel

  // MARK: - Private Properties

  private var navigationConfiguration: NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(icon: "xmark") {
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
    Text("Developer Menu")
      .navigationBar(navigationConfiguration)
  }
}
