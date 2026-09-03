//
//  OnboardingAccountScreen.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import SwiftUI
import BTCoreUI

/// Second onboarding step: name the first account and pick its currency.
public struct OnboardingAccountScreen: View {
  // MARK: - Observed Properties

  @ObservedObject private var viewModel: OnboardingAccountViewModel
  @Environment(BTTheme.self)
  private var theme

  // MARK: - Computed Properties

  private var uiModel: OnboardingAccountUIModel {
    viewModel.uiModel
  }

  // MARK: - Init

  public init(viewModel: OnboardingAccountViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: theme.spacing.spacerXL) {
        ProgressBar(progress: .constant(uiModel.progress))

        VStack(alignment: .leading, spacing: theme.spacing.spacerXS) {
          Text(uiModel.title)
            .font(theme.typography.title.title2)
            .foregroundStyle(theme.colorPalette.text.primary)
          Text(uiModel.subtitle)
            .font(theme.typography.body.subheadline)
            .foregroundStyle(theme.colorPalette.text.secondary)
        }

        InputField(
          text: $viewModel.name,
          label: uiModel.nameFieldLabel,
          placeholder: uiModel.nameFieldPlaceholder,
          hasClearIcon: true
        )

        InputField(
          text: $viewModel.startingBalance,
          label: uiModel.balanceFieldLabel,
          placeholder: uiModel.balanceFieldPlaceholder
        )

        currencySelector
      }
    }
    .contentMargins(theme.spacing.spacerXL)
    .scrollIndicators(.hidden)
    .background(theme.colorPalette.surface.light)
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button { [weak viewModel] in
          viewModel?.handleBackTap()
        } label: {
          Image(systemName: theme.imageCatalog.uiAction.chevronLeft)
        }
      }
      ToolbarItem(placement: .subtitle) {
        Text(uiModel.stepLabel)
          .font(theme.typography.body.footnoteBold)
          .foregroundStyle(theme.colorPalette.text.secondary)
      }
    }
    .safeAreaInset(edge: .bottom) {
      RegularButton(text: uiModel.primaryButtonTitle, imageName: nil) { [weak viewModel] in
        viewModel?.handleContinueTap()
      }
      .padding(.horizontal, theme.spacing.spacerXL)
    }
  }

  // MARK: - Subviews

  private var currencySelector: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerS) {
      Text(uiModel.currencyGroupLabel)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
      Picker(selection: $viewModel.selectedCurrencyIndex) {
        ForEach(uiModel.currencyCodes.indices, id: \.self) { index in
          Text(uiModel.currencyCodes[index]).tag(index)
        }
      } label: {
        Text(String())
      }
      .pickerStyle(.segmented)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
