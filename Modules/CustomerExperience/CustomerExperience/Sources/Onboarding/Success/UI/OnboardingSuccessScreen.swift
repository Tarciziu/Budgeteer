//
//  OnboardingSuccessScreen.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import SwiftUI
import BTCoreUI

/// Final onboarding step: success confirmation with a summary of what was set up.
public struct OnboardingSuccessScreen: View {
  // MARK: - Nested Types

  private enum Constants {
    static let checkCircleDiameter: CGFloat = 128
    static let checkSymbolSize: CGFloat = 56
  }

  // MARK: - Observed Properties

  @ObservedObject private var viewModel: OnboardingSuccessViewModel
  @Environment(BTTheme.self)
  private var theme

  // MARK: - Computed Properties

  private var uiModel: OnboardingSuccessUIModel {
    viewModel.uiModel
  }

  // MARK: - Init

  public init(viewModel: OnboardingSuccessViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  public var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXL) {
        checkCircle
        VStack(spacing: theme.spacing.spacerM) {
          Text(uiModel.title)
            .font(theme.typography.title.title1)
            .foregroundStyle(theme.colorPalette.text.primary)
          Text(uiModel.subtitle)
            .font(theme.typography.body.subheadline)
            .foregroundStyle(theme.colorPalette.text.secondary)
        }
        .multilineTextAlignment(.center)

        summaryCard
      }
      .frame(maxWidth: .infinity)
      .padding(.top, theme.spacing.spacerXXL)
    }
    .contentMargins(theme.spacing.spacerXL)
    .scrollIndicators(.hidden)
    .background(theme.colorPalette.surface.light)
    .safeAreaInset(edge: .bottom) {
      RegularButton(text: uiModel.primaryButtonTitle, imageName: nil) { [weak viewModel] in
        viewModel?.handleGoToHomeTap()
      }
      .padding(.horizontal, theme.spacing.spacerXL)
    }
  }

  // MARK: - Subviews

  private var checkCircle: some View {
    Image(systemName: theme.imageCatalog.uiAction.check)
      .font(.system(size: Constants.checkSymbolSize, weight: .bold))
      .foregroundStyle(theme.colorPalette.text.inverted)
      .frame(width: Constants.checkCircleDiameter, height: Constants.checkCircleDiameter)
      .background(theme.colorPalette.tint.primary, in: Circle())
  }

  private var summaryCard: some View {
    VStack(spacing: .zero) {
      ForEach(Array(uiModel.rows.enumerated()), id: \.element.id) { index, row in
        ValueListCell(
          content: .init(
            leadingContent: .init(title: row.label),
            trailingContent: .init(
              title: row.value,
              titleState: row.isHighlighted ? .positive : .neutral
            ),
            hasDivider: index != uiModel.rows.count - 1
          )
        )
      }
    }
    .background(theme.colorPalette.surface.primary)
    .clipShape(.rect(cornerRadius: theme.borderRadius.radiusXXL))
    .overlay {
      RoundedRectangle(cornerRadius: theme.borderRadius.radiusXXL)
        .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
    }
  }
}
