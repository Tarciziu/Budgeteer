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
      fields
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
    .alert(
      viewModel.validationAlertTitle,
      isPresented: Binding(
        get: { viewModel.validationMessage != nil },
        set: { isPresented in
          if !isPresented { viewModel.dismissValidationAlert() }
        }
      ),
      presenting: viewModel.validationMessage
    ) { _ in
      Button(viewModel.validationAlertDismissTitle, role: .cancel) {}
    } message: { message in
      Text(message)
    }
  }

  @ViewBuilder private var fields: some View {
    VStack(spacing: .zero) {
      makeInputField(
        with: $viewModel.model.title,
        label: viewModel.localizedStrings.titleLabel
      )
      makeInputField(
        with: $viewModel.model.amount,
        label: viewModel.localizedStrings.amountLabel
      )
      VStack(spacing: theme.spacing.spacerM) {
        makeInputField(
          with: $viewModel.model.description,
          label: viewModel.localizedStrings.descriptionLabel
        )
        dateInputField
        makeCategoryPicker()
      }
    }
  }

  @ViewBuilder private var dateInputField: some View {
    HStack(spacing: .zero) {
      Text(viewModel.localizedStrings.dateLabel)
        .font(theme.typography.body.subheadline)
        .foregroundColor(theme.colorPalette.text.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
      Spacer()
      datePicker
    }
  }

  @ViewBuilder private var datePicker: some View {
    DatePicker(
      String(),
      selection: $viewModel.model.transactionDate,
      in: Date.distantPast...Date.now,
      displayedComponents: [.date, .hourAndMinute]
    )
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

  @ViewBuilder
  private func makeCategoryPicker() -> some View {
    let chips = viewModel.getCategories().map { category in
      ChipButton.Content(
        label: category.title,
        isSelected: viewModel.model.category == category
      ) { [weak viewModel] in
        viewModel?.selectCategory(category)
      }
    }
    ChipGroup(
      label: viewModel.localizedStrings.categoryLabel,
      chips: chips
    )
    .frame(maxWidth: .infinity)
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
