//
//  AppLaunchFailureScreen.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import SwiftUI
import BTCoreUI

/// Full-screen fallback shown when the app cannot determine its initial phase.
struct AppLaunchFailureScreen: View {
  // MARK: - Observed Properties

  @ObservedObject private var viewModel: AppLaunchFailureViewModel
  @Environment(BTTheme.self)
  private var theme

  // MARK: - Computed Properties

  private var uiModel: AppLaunchFailureUIModel {
    viewModel.uiModel
  }

  // MARK: - Init

  /// Creates a new `AppLaunchFailureScreen`.
  /// - Parameter viewModel: The view model associated with the screen.
  init(viewModel: AppLaunchFailureViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  var body: some View {
    VStack {
      Spacer()
      messageBlock
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal, theme.spacing.spacerXL)
    .background(theme.colorPalette.surface.light)
    .safeAreaInset(edge: .bottom) {
      RegularButton(text: uiModel.retryButtonTitle, imageName: nil) { [weak viewModel] in
        viewModel?.handleRetryTap()
      }
      .isLoading(viewModel.isRetrying)
      .padding(.horizontal, theme.spacing.spacerXL)
    }
  }

  // MARK: - Subviews

  private var messageBlock: some View {
    VStack(spacing: theme.spacing.spacerS) {
      Text(uiModel.title)
        .font(theme.typography.title.title2)
        .foregroundStyle(theme.colorPalette.text.primary)
        .multilineTextAlignment(.center)
      Text(uiModel.message)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
        .multilineTextAlignment(.center)
    }
  }
}
