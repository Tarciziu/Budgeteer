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
        // TODO: Add date picker when implemented and visual transformation for date
        makeInputField(
          with: $viewModel.model.transactionDate,
          label: viewModel.localizedStrings.dateLabel
        )
      }
    }
    .contentMargins(theme.spacing.spacerL)
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

  // MARK: - Navigation Configuration

  private func makeConfiguration() -> NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(icon: "xmark") { [weak viewModel] in
      viewModel?.requestDismiss()
    }
    return NavigationBarConfiguration(
      title: viewModel.localizedStrings.screenTitle,
      trailingAction: trailingAction
    )
  }
}
