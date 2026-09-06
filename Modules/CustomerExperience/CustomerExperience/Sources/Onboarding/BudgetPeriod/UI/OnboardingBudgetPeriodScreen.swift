//
//  OnboardingBudgetPeriodScreen.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import SwiftUI
import BTCoreUI

/// Screen containing the time period configuration for the initial budget in the onboarding flow.
public struct OnboardingBudgetPeriodScreen: View {
  // MARK: - Observed Properties

  @ObservedObject private var viewModel: OnboardingBudgetPeriodViewModel
  @Environment(BTTheme.self)
  private var theme

  // MARK: - State

  @State private var isStartDatePickerExpanded = false

  // MARK: - Computed Properties

  private var uiModel: OnboardingBudgetPeriodUIModel {
    viewModel.uiModel
  }

  // MARK: - Init

  /// Creates a new `OnboardingBudgetPeriodScreen`
  /// - Parameter viewModel: The view model associated with the screen.
  public init(viewModel: OnboardingBudgetPeriodViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  public var body: some View {
    ScrollView {
      content
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
      .isLoading(viewModel.isCreatingPlan)
      .padding(.horizontal, theme.spacing.spacerXL)
    }
    .alert(
      uiModel.creationErrorTitle,
      isPresented: $viewModel.hasCreationError
    ) {
      Button(uiModel.creationErrorDismissTitle, role: .cancel) {}
    } message: {
      Text(uiModel.creationErrorMessage)
    }
  }

  // MARK: - Subviews

  private var content: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerXL) {
      ProgressBar(progress: .constant(uiModel.progress))
      header
      startDateSection
      HighlightCard(
        label: uiModel.previewCardLabel,
        value: uiModel.previewRangeText,
        caption: uiModel.previewCaption
      )
    }
  }

  private var startDateSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerS) {
      LabeledValueRow(
        label: uiModel.startDateLabel,
        value: uiModel.startDateText,
        isExpanded: isStartDatePickerExpanded
      ) {
        withAnimation {
          isStartDatePickerExpanded.toggle()
        }
      }
      if isStartDatePickerExpanded {
        startDatePicker
      }
    }
  }

  private var startDatePicker: some View {
    DatePicker(
      String(),
      selection: $viewModel.selectedStartDate,
      in: viewModel.minimumStartDate...,
      displayedComponents: .date
    )
    .datePickerStyle(.graphical)
    .labelsHidden()
    .tint(theme.colorPalette.tint.primary)
    .padding(theme.spacing.spacerS)
    .frame(maxWidth: .infinity)
    .background(theme.colorPalette.surface.primary)
    .clipShape(.rect(cornerRadius: theme.borderRadius.radiusXL))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusXL)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
    .transition(.opacity.combined(with: .move(edge: .top)))
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerXS) {
      Text(uiModel.title)
        .font(theme.typography.title.title2)
        .foregroundStyle(theme.colorPalette.text.primary)
      Text(uiModel.subtitle)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }
}
