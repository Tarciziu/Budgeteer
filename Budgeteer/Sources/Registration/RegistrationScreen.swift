//
//  RegistrationScreen.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11.09.2025.
//

import Foundation
import SwiftUI
import BTCoreUI

/// Dummy registration screen used to showcase the functionality of the main flow.
struct RegistrationScreen: View {
  // MARK: - Private Properties

  private let onTap: () -> Void

  // MARK: - Init

  init(onTap: @escaping () -> Void) {
    self.onTap = onTap
  }

  // MARK: - Body

  var body: some View {
    VStack(spacing: Spacing.mainSpacing.spacerXXL) {
      Text("This is a dummy registration screen")
        .bold()
      Button {
        onTap()
      } label: {
        Text("Proceed to main app")
      }
    }
  }
}
