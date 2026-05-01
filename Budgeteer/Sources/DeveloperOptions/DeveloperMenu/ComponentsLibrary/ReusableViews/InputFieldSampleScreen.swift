//
//  InputFieldSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import SwiftUI
import BTCoreUI

struct InputFieldSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - State Properties

  @State private var normalText = ""
  @State private var prefilledText = "John Doe"
  @State private var clearableText = "Clearable"
  @State private var errorText = ""
  @State private var disabledText = "Disabled"
  @State private var iconText = ""

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXL) {
        normalSection
        prefilledSection
        clearableSection
        errorSection
        disabledSection
        iconsSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Input Fields"))
  }

  // MARK: - Sections

  private var normalSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Normal")
      InputField(text: $normalText, label: "Full Name", placeholder: "Enter your name")
    }
  }

  private var prefilledSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Prefilled")
      InputField(text: $prefilledText, label: "Full Name", placeholder: "Enter your name")
    }
  }

  private var clearableSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Clearable")
      InputField(text: $clearableText, label: "Search", placeholder: "Type to search", hasClearIcon: true)
    }
  }

  private var errorSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Error State")
      InputField(
        text: $errorText,
        label: "Email",
        placeholder: "Enter email",
        inputFieldState: .error,
        caption: "Invalid email address"
      )
    }
  }

  private var disabledSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Disabled")
      InputField(text: $disabledText, label: "Username", inputFieldState: .disabled)
    }
  }

  private var iconsSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("With Icons")
      InputField(
        text: $iconText,
        label: "Password",
        placeholder: "Enter password",
        leadingIconConfig: .init(name: "lock", action: nil),
        trailingIconConfig: .init(name: "eye", action: nil)
      )
    }
  }

  // MARK: - Helpers

  private func sectionLabel(_ text: String) -> some View {
    Text(text)
      .font(theme.typography.title.headline)
      .foregroundStyle(theme.colorPalette.text.primary)
  }
}
