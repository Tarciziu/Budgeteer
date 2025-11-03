//
//  RemindersList.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import SwiftUI
import BTCoreUI

/// UI element serving as the container for the reminders list page.
public struct RemindersList: View {
  // MARK: - Observed Properteis

  @Environment(BTTheme.self)
  private var theme

  @ObservedObject private var viewModel: RemindersListViewModel

  // MARK: - Private Properties

  private let navigationBarConfig: NavigationBarConfiguration

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
    Text("RemindersList")
      .navigationBar(navigationBarConfig)
  }
}
