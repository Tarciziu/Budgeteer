//
//  OnboardingIconBadge.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import SwiftUI
import BTCoreUI

/// A large tinted circle with a centered SF Symbol, used as the hero illustration on the
/// onboarding welcome slides.
struct OnboardingIconBadge: View {
  // MARK: - Nested Types

  private enum Constants {
    static let diameter: CGFloat = 160
    static let symbolSize: CGFloat = 64
    static let backgroundOpacity: CGFloat = 0.12
  }

  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  private let systemImage: String

  // MARK: - Init

  init(systemImage: String) {
    self.systemImage = systemImage
  }

  // MARK: - Body

  var body: some View {
    Image(systemName: systemImage)
      .font(.system(size: Constants.symbolSize))
      .foregroundStyle(theme.colorPalette.tint.primary)
      .frame(width: Constants.diameter, height: Constants.diameter)
      .background(
        theme.colorPalette.tint.primary.opacity(Constants.backgroundOpacity),
        in: Circle()
      )
  }
}
