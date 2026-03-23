//
//  RemindersList.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import SwiftUI
import BTCoreUI
import BTCore

/// UI element serving as the container for the reminders list page.
public struct RemindersList: View {
  // MARK: - Observed Properteis

  @Environment(BTTheme.self)
  private var theme

  @ObservedObject private var viewModel: RemindersListViewModel

  // MARK: - Private Properties

  private let navigationBarConfig: NavigationBarConfiguration

  // MARK: - State Properties

  @State private var currentNote: String?
  @State private var isPendingRemindersExpanded = true
  @State private var isExpiredRemindersExpanded = true

  @State private var note: String?

  private var uiModel: RemindersListUIModel {
    viewModel.uiModel
  }

  // MARK: - Init

  /// Creates a new `RemindersList`
  /// - Parameter navigationBar: The content of the navigation bar provided by the integrator.
  public init(
    viewModel: RemindersListViewModel,
    navigationBar: NavigationBarConfiguration
  ) {
    self.navigationBarConfig = navigationBar
    self.viewModel = viewModel
  }

  // MARK: - Body

  public var body: some View {
    switch uiModel.loadingContent {
    case .loaded(let content):
      makeLoadedView(with: content)
    default:
      EmptyView()
    }
  }

  private func makeLoadedView(with content: RemindersListUIModel.LoadingContent) -> some View {
    List {
      makePendingRemindersSection(with: content.pendingRemindersSection)
        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
      makeExpiredRemindersSection(with: content.expiredReminderSection)
        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
    }
    .scrollIndicators(.hidden)
    .listStyle(.inset)
    .padding(.horizontal, theme.spacing.spacerL)
    .padding(.vertical, theme.spacing.spacerXL)
    .navigationBar(navigationBarConfig)
  }

  // MARK: - Subviews

  private func makePendingRemindersSection(
    with sectionContent: RemindersListUIModel.RemindersSection
  ) -> some View {
    Section(isExpanded: $isPendingRemindersExpanded) {
      makeRemindersList(content: sectionContent.reminders
      ) { index in
        viewModel.handlePendingReminderDelete(at: index)
      } onEditTap: { index in
        viewModel.handlePendingReminderEdit(at: index)
      }
    } header: {
      RemindersSectionHeader(
        title: sectionContent.title,
        isSectionExpanded: $isPendingRemindersExpanded
      )
    }
  }

  private func makeExpiredRemindersSection(with sectionContent: RemindersListUIModel.RemindersSection) -> some View {
    Section(isExpanded: $isExpiredRemindersExpanded) {
      makeRemindersList(content: sectionContent.reminders) { index in
        viewModel.handleExpiredReminderDelete(at: index)
      }
    } header: {
      RemindersSectionHeader(
        title: sectionContent.title,
        isSectionExpanded: $isExpiredRemindersExpanded
      )
    }
  }

  private func makeRemindersList(
    content: [RemindersListUIModel.ReminderUIModel],
    onDeleteTap: @escaping (Int) -> Void,
    onEditTap: ((Int) -> Void)? = nil,
  ) -> some View {
    VStack(spacing: theme.spacing.spacerM) {
      ForEach(content, id: \.id) { reminder in
        let index = content.firstIndex { $0 == reminder } ?? .zero
        makeReminderCell(
          with: reminder,
          at: index,
          onDeleteTap: { index in
            onDeleteTap(index)
          },
          onEditTap: onEditTap)
        .buttonStyle(.plain)
      }
    }
  }

  private func makeReminderCell(
    with reminder: RemindersListUIModel.ReminderUIModel,
    at index: Int,
    onDeleteTap: @escaping (Int) -> Void,
    onEditTap: ((Int) -> Void)?
  ) -> some View {
    MenuListCell(
      content: .init(
        title: reminder.title,
        subtitle: .init(label: reminder.caption, icon: nil),
        performance: makeMenuCellPerformance(from: reminder.performance),
        leadingButtons: makeLeadingButtonsContent(for: reminder),
        trailingButtons: makeTrailingButtonsContent(
          for: reminder,
          at: index,
          onDeleteTap: {
            onDeleteTap(index)
          },
          onEditTap: onEditTap
        )
      )
    )
  }

  private func makeMenuCellPerformance(
    from reminderPerformanceUIModel: RemindersListUIModel.Performance?
  ) -> MenuListCell.Performance? {
    guard let reminderPerformanceUIModel else {
      return nil
    }
    switch reminderPerformanceUIModel.type {
    case .positive:
      return MenuListCell.Performance(label: reminderPerformanceUIModel.label, type: .positive)
    case .negative:
      return MenuListCell.Performance(label: reminderPerformanceUIModel.label, type: .negative)
    case .neutral:
      return MenuListCell.Performance(label: reminderPerformanceUIModel.label, type: .neutral)
    }
  }

  private func makeLeadingButtonsContent(
    for reminder: RemindersListUIModel.ReminderUIModel
  ) -> [PillButton.Content] {
    var buttons: [PillButton.Content] = []
    if let note = reminder.note {
      let buttonContent = PillButton.Content(
        label: uiModel.staticContent.noteLabel,
        type: .highlight
      ) {
        currentNote = note
      }
      buttons.append(buttonContent)
    }
    return buttons
  }

  private func makeTrailingButtonsContent(
    for reminder: RemindersListUIModel.ReminderUIModel,
    at index: Int,
    onDeleteTap: @escaping () -> Void,
    onEditTap: ((Int) -> Void)?
  ) -> [PillButton.Content] {
    var buttons: [PillButton.Content] = []
    let deleteButtonContent = PillButton.Content(label: uiModel.staticContent.deleteLabel, type: .error, action: onDeleteTap)
    buttons.append(deleteButtonContent)
    if let onEditTap {
      let editButtonContet = PillButton.Content(label: uiModel.staticContent.editLabel) {
        onEditTap(index)
      }
      buttons.append(editButtonContet)
    }
    return buttons
  }
}

// MARK: - UI Components

private struct RemindersSectionHeader: View {
  @Environment(BTTheme.self)
  private var theme

  let title: String
  @Binding private var isSectionExpanded: Bool

  init(title: String, isSectionExpanded: Binding<Bool>) {
    self.title = title
    self._isSectionExpanded = isSectionExpanded
  }

  var body: some View {
    Button {
      withAnimation {
        isSectionExpanded.toggle()
      }
    } label: {
      content
    }
  }

  private var content: some View {
    HStack {
      titleView
      Spacer()
      image
    }
  }

  private var titleView: some View {
    Text(title)
      .foregroundStyle(theme.colorPalette.text.primary)
      .font(theme.typography.title.title1)
  }

  private var iconName: String {
    isSectionExpanded ? theme.imageCatalog.uiAction.chevronDown : theme.imageCatalog.uiAction.chevronRight
  }

  private var image: some View {
    Image(systemName: iconName)
      .resizable()
      .frame(width: theme.iconSize.iconXXS, height: theme.iconSize.iconXXS)
      .foregroundStyle(theme.colorPalette.icon.primary)
  }
}
