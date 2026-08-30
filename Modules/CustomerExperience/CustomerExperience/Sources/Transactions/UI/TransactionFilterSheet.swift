//
//  TransactionFilterSheet.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 29/04/2026.
//

import SwiftUI
import BTCoreUI

/// Sheet view for configuring transaction list filters.
struct TransactionFilterSheet: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.dismiss)
  private var dismiss

  // MARK: - State Properties

  @State private var dateFilterMode: DateFilterMode = .none
  @State private var beforeDate = Date()
  @State private var afterDate = Date()
  @State private var startDate = Date()
  @State private var endDate = Date()
  @State private var selectedCategory: TransactionCategoryUIModel?

  // MARK: - Private Properties

  private let currentFilters: [TransactionFilter]
  private let onApply: ([TransactionFilter]) -> Void
  private let onReset: () -> Void

  // MARK: - Initializer

  init(
    currentFilters: [TransactionFilter],
    onApply: @escaping ([TransactionFilter]) -> Void,
    onReset: @escaping () -> Void
  ) {
    self.currentFilters = currentFilters
    self.onApply = onApply
    self.onReset = onReset
  }

  // MARK: - Body

  var body: some View {
    NavigationStack {
      content
        .navigationBar(makeConfiguration())
    }
    .onAppear {
      restoreFromCurrentFilters()
    }
  }

  // MARK: - Subviews

  private var content: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        dateFilterSection
        categoryFilterSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .safeAreaInset(edge: .bottom) {
      actionButtons
    }
  }

  // MARK: - Date Filter Section

  private var dateFilterSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel(TransactionFilterStrings.dateFilterLabel)
      dateModePicker
      datePickersForMode
    }
  }

  private var dateModePicker: some View {
    Picker(TransactionFilterStrings.dateFilterLabel, selection: $dateFilterMode) {
      ForEach(DateFilterMode.allCases, id: \.rawValue) { mode in
        Text(mode.displayLabel).tag(mode)
      }
    }
    .pickerStyle(.segmented)
  }

  @ViewBuilder private var datePickersForMode: some View {
    switch dateFilterMode {
    case .none:
      EmptyView()
    case .before:
      makeDatePicker(
        label: TransactionFilterStrings.beforeLabel,
        selection: $beforeDate
      )
    case .after:
      makeDatePicker(
        label: TransactionFilterStrings.afterLabel,
        selection: $afterDate
      )
    case .between:
      makeDatePicker(
        label: TransactionFilterStrings.startDateLabel,
        selection: $startDate
      )
      makeDatePicker(
        label: TransactionFilterStrings.endDateLabel,
        selection: $endDate
      )
    }
  }

  // MARK: - Category Filter Section

  private var categoryFilterSection: some View {
    let chips = TransactionCategoryUIMapper().allCategories().map { category in
      ChipButton.Content(
        label: category.title,
        isSelected: selectedCategory == category
      ) {
        selectCategory(category)
      }
    }
    return ChipGroup(label: TransactionFilterStrings.categoryFilterLabel, chips: chips)
  }

  // MARK: - Action Buttons

  private var actionButtons: some View {
    HStack(spacing: theme.spacing.spacerM) {
      RegularButton(type: .secondary, text: TransactionFilterStrings.resetLabel, imageName: nil) {
        resetFilters()
      }
      RegularButton(text: TransactionFilterStrings.applyLabel, imageName: nil) {
        applyFilters()
      }
    }
    .padding(.horizontal, theme.spacing.spacerL)
    .padding(.bottom, theme.spacing.spacerL)
  }

  // MARK: - View Builders

  private func sectionLabel(_ text: String) -> some View {
    VStack(spacing: .zero) {
      Text(text)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
      RegularDivider()
    }
  }

  private func makeDatePicker(label: String, selection: Binding<Date>) -> some View {
    DatePicker(
      label,
      selection: selection,
      displayedComponents: .date
    )
    .datePickerStyle(.compact)
    .font(theme.typography.body.body)
    .foregroundStyle(theme.colorPalette.text.primary)
  }

  // MARK: - Navigation Configuration

  private func makeConfiguration() -> NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(icon: theme.imageCatalog.uiAction.close) {
      dismiss()
    }
    return NavigationBarConfiguration(
      title: TransactionFilterStrings.filtersTitle,
      trailingAction: trailingAction
    )
  }

  // MARK: - Actions

  private func selectCategory(_ category: TransactionCategoryUIModel) {
    if selectedCategory == category {
      selectedCategory = nil
    } else {
      selectedCategory = category
    }
  }

  private func applyFilters() {
    var filters: [TransactionFilter] = []
    switch dateFilterMode {
    case .none:
      break
    case .before:
      filters.append(.beforeDate(beforeDate))
    case .after:
      filters.append(.afterDate(afterDate))
    case .between:
      filters.append(.betweenDates(start: startDate, end: endDate))
    }
    if let selectedCategory {
      filters.append(.category(selectedCategory))
    }
    onApply(filters)
    dismiss()
  }

  private func resetFilters() {
    dateFilterMode = .none
    beforeDate = Date()
    afterDate = Date()
    startDate = Date()
    endDate = Date()
    selectedCategory = nil
    onReset()
    dismiss()
  }

  private func restoreFromCurrentFilters() {
    for filter in currentFilters {
      switch filter {
      case let .beforeDate(date):
        dateFilterMode = .before
        beforeDate = date
      case let .afterDate(date):
        dateFilterMode = .after
        afterDate = date
      case let .betweenDates(start, end):
        dateFilterMode = .between
        startDate = start
        endDate = end
      case let .category(category):
        selectedCategory = category
      }
    }
  }
}
