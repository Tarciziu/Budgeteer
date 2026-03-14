//
//  TransactionsScreen.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import SwiftUI
import BTCoreUI

/// Main screen of transactions list feature.
public struct TransactionsScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  @ObservedObject private var viewModel: TransactionsViewModel

  // MARK: - Initializer

  /// Initializes a new ``TransactionsScreen``.
  /// - Parameter viewModel: The view model managing the state and logic of the transactions list.
  public init(viewModel: TransactionsViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  public var body: some View {
    LoadableContentView(content: viewModel.transactions) {
      EmptyView()
    } loadingView: { _ in
      loadingView
    } loadedView: { transactions in
      makeTransactionsListView(transactions: transactions)
    } failureView: { _ in
      EmptyView()
    }
    .navigationBar(makeConfiguration())
    .onAppear {
      viewModel.loadTransactions()
    }
  }

  // MARK: - Subviews

  @ViewBuilder private var loadingView: some View {
    // TODO: Replace with a proper loading state strings.
    let leadingContent = ValueListCell.LeadingContent(
      title: "Loading...",
      caption: "Loading..."
    )
    let trailingContent = ValueListCell.TrailingContent(
      title: "Loading...",
      titleState: .neutral,
      caption: "Loading..."
    )
    let content = ValueListCell.Content(
      leadingContent: leadingContent,
      trailingContent: trailingContent,
      hasDivider: true
    )
    ValueListCell(content: content)
      .frame(maxWidth: .infinity)
  }

  private var roundingShape: some Shape {
    RoundedRectangle(cornerRadius: theme.borderRadius.radiusM)
  }

  private var borderView: some View {
    roundingShape
      .stroke(theme.colorPalette.border.primary, lineWidth: theme.spacing.lineWidth)
  }

  // MARK: - Navigation Configuration

  private func makeConfiguration() -> NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(icon: "plus") { [weak viewModel] in
      viewModel?.handleNewTransaction()
    }
    return NavigationBarConfiguration(
      title: TransactionsViewModel.Constants.screenTitle,
      trailingAction: trailingAction
    )
  }

  // MARK: - ViewBuilders

  @ViewBuilder
  private func makeTransactionsListView(transactions: TransactionsListUIModel) -> some View {
    ScrollView {
      switch transactions {
      case let .full(sections):
        makeSections(sections: sections)
      case let .compact(transactions):
        makeCompactTransactionsList(transactions: transactions)
      }
    }
    .contentMargins(.horizontal, theme.spacing.spacerL)
    .scrollIndicators(.hidden)
  }

  // MARK: - Full Transactions List

  @ViewBuilder
  private func makeSections(sections: [TransactionSectionUIModel]) -> some View {
    LazyVStack(spacing: theme.spacing.spacerXXL) {
      ForEach(sections) { section in
        makeSection(section: section)
      }
    }
    .frame(maxHeight: .infinity)
  }

  @ViewBuilder
  private func makeSection(section: TransactionSectionUIModel) -> some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerL) {
      makeSectionHeader(section: section)
      VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
        ForEach(section.transactions) { transaction in
          makeTransaction(transaction: transaction, hasDivider: section.transactions.last != transaction)
        }
      }
      .glassEffect(.regular, in: roundingShape)
      .overlay {
        borderView
      }
    }
  }

  @ViewBuilder
  private func makeSectionHeader(section: TransactionSectionUIModel) -> some View {
    Text(section.title)
      .foregroundStyle(theme.colorPalette.text.primary)
      .font(theme.typography.title.title3)
  }

  // MARK: - Compact Transactions List

  @ViewBuilder
  private func makeCompactTransactionsList(transactions: [TransactionUIModel]) -> some View {
    VStack(spacing: .zero) {
      ForEach(transactions) { transaction in
        makeTransaction(transaction: transaction, hasDivider: transactions.last != transaction)
      }
    }
  }

  // MARK: - Common

  @ViewBuilder
  private func makeTransaction(transaction: TransactionUIModel, hasDivider: Bool) -> some View {
    let leadingContent = ValueListCell.LeadingContent(
      title: transaction.title,
      caption: transaction.subtitle
    )
    let trailingContent = ValueListCell.TrailingContent(
      title: transaction.amount,
      titleState: transaction.isPositiveAmount ? .positive : .negative,
      caption: transaction.transactionDate
    )
    let content = ValueListCell.Content(
      leadingContent: leadingContent,
      trailingContent: trailingContent,
      hasDivider: hasDivider
    )
    ValueListCell(content: content)
      .frame(maxWidth: .infinity)
  }
}
