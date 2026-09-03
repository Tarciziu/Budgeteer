//
//  OnboardingWelcomeScreen.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import SwiftUI
import BTCoreUI

/// First onboarding screen: a 3-slide intro carousel with a primary call to action.
public struct OnboardingWelcomeScreen: View {
  // MARK: - Observed Properties

  @ObservedObject private var viewModel: OnboardingWelcomeViewModel
  @Environment(BTTheme.self)
  private var theme

  // MARK: - Computed Properties

  /// Bridges the index-based view model to the pager's `Binding<Item>`, mirroring the
  /// `selectedIndex` bridge inside ``HorizontalPagerView``.
  private var selectedSlideBinding: Binding<OnboardingWelcomeUIModel.Slide> {
    Binding(
      get: {
        let slides = viewModel.uiModel.slides
        let index = slides.indices.contains(viewModel.selectedSlideIndex) ? viewModel.selectedSlideIndex : 0
        return slides[index]
      },
      set: { newValue in
        if let index = viewModel.uiModel.slides.firstIndex(of: newValue) {
          viewModel.selectedSlideIndex = index
        }
      }
    )
  }

  // MARK: - Init

  public init(viewModel: OnboardingWelcomeViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  public var body: some View {
    HorizontalPagerView(
      items: viewModel.uiModel.slides,
      selectedItem: selectedSlideBinding,
      hasPageControl: true
    ) { slide in
      slideView(slide)
    }
    .itemWidthRatio(1)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(theme.colorPalette.surface.light)
    .safeAreaInset(edge: .bottom) {
      RegularButton(text: viewModel.primaryButtonTitle, imageName: nil) { [weak viewModel] in
        viewModel?.handlePrimaryButtonTap()
      }
      .padding(.horizontal, theme.spacing.spacerXL)
    }
  }

  // MARK: - Subviews

  private func slideView(_ slide: OnboardingWelcomeUIModel.Slide) -> some View {
    VStack(spacing: theme.spacing.spacerXL) {
      Spacer(minLength: .zero)
      OnboardingIconBadge(systemImage: slide.systemImage)
      VStack(spacing: theme.spacing.spacerM) {
        Text(slide.title)
          .font(theme.typography.title.title1)
          .foregroundStyle(theme.colorPalette.text.primary)
        Text(slide.subtitle)
          .font(theme.typography.body.subheadline)
          .foregroundStyle(theme.colorPalette.text.secondary)
      }
      .multilineTextAlignment(.center)
      Spacer(minLength: .zero)
    }
    .padding(.horizontal, theme.spacing.spacerXL)
    .frame(maxWidth: .infinity)
  }
}
