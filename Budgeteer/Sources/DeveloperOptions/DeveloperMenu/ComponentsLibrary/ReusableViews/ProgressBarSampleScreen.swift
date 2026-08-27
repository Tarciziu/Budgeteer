//
//  ProgressBarSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 23/08/2026.
//

import SwiftUI
import BTCoreUI

struct ProgressBarSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        ProgressBar(progress: .constant(0.5))
        ProgressBar(progress: .constant(1))
        ProgressBar(progress: .constant(1))
          .isLoading(true)
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Progress Bar"))
  }

  // MARK: - Card Buttons


}
