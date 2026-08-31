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
  // MARK: - Nested Types

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
        ammountAndCurrencySection
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
    .onAppear {
      viewModel.handleViewAppear()
    }
  }

  // MARK: - Subviews

  private var reminderderTitleSection: some View {
    InputField(
      text: $viewModel.reminderTitleText,
      label: uiModel.reminderTitleLabel,
      placeholder: uiModel.reminderTitlePlaceholder,
      inputFieldState: viewModel.hasInputError ? .error : .normal,
      caption: viewModel.hasInputError ? uiModel.nameErrorText : nil
    )
  }

  private var reminderDateSection: some View {
    VStack(alignment: .trailing, spacing: theme.spacing.spacerS) {
      DatePicker(selection: $viewModel.reminderDate, in: viewModel.minimumReminderDate...) {
        Text(uiModel.reminderDateLabel)
          .font(theme.typography.body.subheadline)
          .foregroundStyle(
            viewModel.haseDateError ? theme.colorPalette.text.negative : theme.colorPalette.text.secondary
          )
      }
      .datePickerStyle(.compact)
      if viewModel.haseDateError {
        dateError
      }
    }
    .padding(theme.spacing.spacerL)
  }

  private var ammountAndCurrencySection: some View {
    VStack(spacing: theme.spacing.spacerXS) {
      amountSection
      currency
    }
  }

  private var amountSection: some View {
    InputField(
      text: $viewModel.amount,
      label: uiModel.reminderAmountLabel,
      visualTransformation: viewModel.visualTransformation
    )
  }

  private var currency: some View {
    Picker.init(selection: $viewModel.selectedCurrencyIndex) {
      let currencies = uiModel.availableCurrencties
      ForEach(uiModel.availableCurrencties.indices, id: \.self) { currencyIndex in
        Text(currencies[currencyIndex]).tag(currencyIndex)
      }
    } label: {
      Text(String())
    }
    .pickerStyle(.segmented)
    .padding(.horizontal, theme.spacing.spacerL)
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

  private var dateError: some View {
    Text(uiModel.dateErrorText)
      .font(theme.typography.body.footnote)
      .foregroundStyle(theme.colorPalette.text.negative)
  }
}
