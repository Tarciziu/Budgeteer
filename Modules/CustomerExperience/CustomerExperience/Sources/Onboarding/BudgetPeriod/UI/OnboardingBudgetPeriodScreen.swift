//
//  OnboardingBudgetPeriodScreen.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import SwiftUI
import BTCoreUI

/// Third onboarding step: confirm the 30-day budget period.
public struct OnboardingBudgetPeriodScreen: View {
  // MARK: - Observed Properties

  @ObservedObject private var viewModel: OnboardingBudgetPeriodViewModel
  @Environment(BTTheme.self)
  private var theme

  // MARK: - Computed Properties

  private var uiModel: OnboardingBudgetPeriodUIModel {
    viewModel.uiModel
  }

  // MARK: - Init

  public init(viewModel: OnboardingBudgetPeriodViewModel) {
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

        startDateRow
        previewCard
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
        viewModel?.handleCreateTap()
      }
      .padding(.horizontal, theme.spacing.spacerXL)
    }
  }

  // MARK: - Subviews

  private var startDateRow: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerXS) {
      Text(uiModel.startDateLabel)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
      HStack {
        Text(uiModel.startDateText)
          .font(theme.typography.body.body)
          .foregroundStyle(theme.colorPalette.text.primary)
        Spacer()
        Image(systemName: theme.imageCatalog.uiAction.chevronRight)
          .resizable()
          .scaledToFit()
          .fontWeight(.semibold)
          .frame(width: 8, height: theme.iconSize.iconS)
          .foregroundStyle(theme.colorPalette.text.secondary)
      }
      .padding(theme.spacing.spacerL)
      .frame(maxWidth: .infinity)
      .background(theme.colorPalette.surface.primary)
      .clipShape(.rect(cornerRadius: theme.borderRadius.radiusXL))
      .overlay {
        RoundedRectangle(cornerRadius: theme.borderRadius.radiusXL)
          .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
      }
    }
  }

  private var previewCard: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerS) {
      Text(uiModel.previewCardLabel)
        .font(theme.typography.caption.caption1Bold)
        .foregroundStyle(theme.colorPalette.text.secondary)
      Text(uiModel.previewRangeText)
        .font(theme.typography.title.title2)
        .foregroundStyle(theme.colorPalette.tint.primary)
      Text(uiModel.previewCaption)
        .font(theme.typography.body.footnote)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(theme.spacing.spacerL)
    .background(theme.colorPalette.surface.primary)
    .clipShape(.rect(cornerRadius: theme.borderRadius.radiusXXL))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusXXL)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
  }
}
