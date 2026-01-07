//
//  ReminderConfigurationPage.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.01.2026.
//

import SwiftUI
import BTCoreUI

/// UI entity responsbile for displaying the reminder configuration page.
public struct ReminderConfigurationPage: View {
  // MARK: - Observed Properties

  @Environment(BTTheme.self)
  private var theme
  @Bindable private var viewModel: ReminderConfigurationViewModel

  // MARK: - Computed Properties

  private var uiModel: ReminderConfigurationUIModel {
    viewModel.uiModel
  }

  // MARK: - Private Properties

  private let navigationBarConfiguration: NavigationBarConfiguration

  // MARK: - Init

  /// Creates a new `ReminderConfigurationPage`.
  /// - Parameters:
  ///   - viewModel: The presentation layer entity responsible for managing it.
  ///   - navigationBarConfiguration: Additional configurations for the navigation bar.
  public init(
    viewModel: ReminderConfigurationViewModel,
    navigationBarConfiguration: NavigationBarConfiguration
  ) {
    self.viewModel = viewModel
    self.navigationBarConfiguration = navigationBarConfiguration
  }

  // MARK: - Body

  public var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerL) {
        reminderderTitleSection
        reminderDateSection
        amountSection
        noteSection
      }
    }
    .scrollIndicators(.hidden)
    .padding(.top, theme.spacing.spacerL)
    .navigationBar(navigationBarConfiguration)
    .safeAreaInset(edge: .bottom) {
      buttonsSet
        .padding(theme.spacing.spacerXXL)
    }
  }

  // MARK: - Subviews

  private var reminderderTitleSection: some View {
    InputField(
      text: $viewModel.reminderTitleText,
      label: uiModel.reminderTitleLabel,
      placeholder: uiModel.reminderTitlePlaceholder
    )
  }

  private var reminderDateSection: some View {
    DatePicker(selection: $viewModel.reminderDate) {
      Text(uiModel.reminderDatePlaceholder)
        .font(theme.typography.body.subheadline)
        .foregroundStyle(theme.colorPalette.text.secondary)
    }
    .datePickerStyle(.compact)
    .padding(theme.spacing.spacerL)
  }

  private var amountSection: some View {
    InputField(
      text: $viewModel.amount,
      label: uiModel.reminderAmountLabel
    )
  }

  private var noteSection: some View {
    InputField(
      text: $viewModel.note,
      label: uiModel.noteLabel,
      placeholder: uiModel.notePlaceholder
    )
  }

  private var buttonsSet: some View {
    HStack(spacing: theme.spacing.spacerM) {
      RegularButton(type: .secondary, text: uiModel.cancelButtonTitle, imageName: nil) {
        viewModel.handleCancelButton()
      }
      RegularButton(type: .primary, text: uiModel.saveButtonTitle, imageName: nil) {
        viewModel.handleSaveButton()
      }
    }
  }
}
