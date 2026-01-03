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

  // MARK: - Private Properties

  private let navigationBarConfiguration: NavigationBarConfiguration

  // MARK: - Init

  /// Creates a new `ReminderConfigurationPage`.
  /// - Parameter viewModel: The presentation layer entity responsible for managing it.
  public init(
    viewModel: ReminderConfigurationViewModel,
    navigationBarConfiguration: NavigationBarConfiguration
  ) {
    self.viewModel = viewModel
    self.navigationBarConfiguration = navigationBarConfiguration
  }

  // MARK: - Body

  public var body: some View {
    Text("ReminderConfigurationPage")
      .navigationBar(navigationBarConfiguration)
  }
}
