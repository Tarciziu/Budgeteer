//
//  TransactionDetailsScreen.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 14.03.2026.
//

import SwiftUI
import BTCoreUI

/// Screen providing information about an existing transaction or the template for a new transaction.
public struct TransactionDetailsScreen: View {
  // MARK: Environment

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Observed Properties

  @ObservedObject private var viewModel: TransactionDetailsViewModel

  // MARK: - Init

  /// Initializes a new ``TransactionDetailsScreen``.
  /// - Parameter viewModel: Instance of ``TransactionDetailsViewModel``.
  public init(viewModel: TransactionDetailsViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  public var body: some View {
    content
      .onAppear { [weak viewModel] in
        viewModel?.loadTransaction()
      }
      .navigationBar(makeConfiguration())
  }

  // MARK: - Subviews

  private var content: some View {
    ScrollView {
      VStack(spacing: .zero) {
        makeInputField(
          with: $viewModel.model.title,
          label: viewModel.localizedStrings.titleLabel
        )
        makeInputField(
          with: $viewModel.model.description,
          label: viewModel.localizedStrings.descriptionLabel
        )
        makeInputField(
          with: $viewModel.model.amount,
          label: viewModel.localizedStrings.amountLabel
        )
        makeCategoryPicker()
        // TODO: Add date picker when implemented and visual transformation for date
        makeInputField(
          with: $viewModel.model.transactionDate,
          label: viewModel.localizedStrings.dateLabel
        )
      }
      .disabled(!viewModel.isActionEnabled)
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .safeAreaInset(edge: .bottom) {
      RegularButton(text: viewModel.actionLabel, imageName: nil) { [weak viewModel] in
        viewModel?.saveTransaction()
      }
      .disabled(!viewModel.isActionEnabled)
    }
    .allowsHitTesting(!viewModel.isOperationOngoing)
  }

  // MARK: - View Builders

  private func makeInputField(
    with binding: Binding<String>,
    label: String
  ) -> some View {
    InputField(
      text: binding,
      label: label
    )
  }

  private func makeCategoryPicker() -> some View {
    let chips = viewModel.getCategories().map { category in
      return ChipButton.Content(
        label: category.title,
        isSelected: viewModel.model.categories.contains(category)
      ) { [weak viewModel] in
        viewModel?.toggleCategory(category)
      }
    }
    return ChipGroup(
      label: viewModel.localizedStrings.categoryLabel,
      chips: chips
    )
  }

  // MARK: - Navigation Configuration

  private func makeConfiguration() -> NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(
      icon: theme.imageCatalog.uiAction.close
    ) { [weak viewModel] in
      viewModel?.requestDismiss()
    }
    return NavigationBarConfiguration(
      title: viewModel.localizedStrings.screenTitle,
      trailingAction: trailingAction
    )
  }
}
