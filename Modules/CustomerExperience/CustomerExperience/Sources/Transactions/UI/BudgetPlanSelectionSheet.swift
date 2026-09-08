//
//  BudgetPlanSelectionSheet.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import SwiftUI
import BTCoreUI

/// Half-height sheet listing every available budget plan so the user can pick the one a
/// transaction belongs to. Selecting a plan reports it back and dismisses the sheet.
struct BudgetPlanSelectionSheet: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  @Environment(\.dismiss)
  private var dismiss

  // MARK: - Private Properties

  private let title: String
  private let plans: [TransactionBudgetPlanUIModel]
  private let selectedPlanID: String
  private let onSelect: (TransactionBudgetPlanUIModel) -> Void

  // MARK: - Initializer

  init(
    title: String,
    plans: [TransactionBudgetPlanUIModel],
    selectedPlanID: String,
    onSelect: @escaping (TransactionBudgetPlanUIModel) -> Void
  ) {
    self.title = title
    self.plans = plans
    self.selectedPlanID = selectedPlanID
    self.onSelect = onSelect
  }

  // MARK: - Body

  var body: some View {
    NavigationStack {
      planList
        .navigationBar(makeConfiguration())
    }
    .presentationDetents([.medium, .large])
    .presentationDragIndicator(.visible)
  }

  // MARK: - Subviews

  private var planList: some View {
    ScrollView {
      VStack(spacing: .zero) {
        ForEach(plans) { plan in
          SelectionListCell(
            content: .init(
              label: plan.name,
              trailingIcon: plan.id == selectedPlanID ? theme.imageCatalog.uiAction.check : nil,
              hasDivider: plan.id != plans.last?.id
            ) {
              onSelect(plan)
              dismiss()
            }
          )
        }
      }
    }
    .contentMargins(.top, theme.spacing.spacerS)
    .scrollIndicators(.hidden)
  }

  // MARK: - Navigation Configuration

  private func makeConfiguration() -> NavigationBarConfiguration {
    let trailingAction = NavigationBarConfiguration.CloseAction(
      icon: theme.imageCatalog.uiAction.close
    ) {
      dismiss()
    }
    return NavigationBarConfiguration(
      title: title,
      trailingAction: trailingAction
    )
  }
}
