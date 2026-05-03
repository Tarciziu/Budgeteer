//
//  AvatarSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import SwiftUI
import BTCoreUI

struct AvatarSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        sizesSection
        shapesSection
        contentTypesSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Avatars"))
  }

  // MARK: - Sizes

  private var sizesSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Sizes")
      HStack(spacing: theme.spacing.spacerXL) {
        VStack(spacing: theme.spacing.spacerS) {
          Avatar(content: .text("L"), size: .large, shape: .circle, hasBorder: true)
          Text("Large").font(theme.typography.body.footnote)
        }
        VStack(spacing: theme.spacing.spacerS) {
          Avatar(content: .text("S"), size: .small, shape: .circle, hasBorder: true)
          Text("Small").font(theme.typography.body.footnote)
        }
      }
      .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  // MARK: - Shapes

  private var shapesSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Shapes")
      HStack(spacing: theme.spacing.spacerXL) {
        VStack(spacing: theme.spacing.spacerS) {
          Avatar(content: .text("C"), size: .large, shape: .circle, hasBorder: true)
          Text("Circle").font(theme.typography.body.footnote)
        }
        VStack(spacing: theme.spacing.spacerS) {
          Avatar(content: .text("S"), size: .large, shape: .square, hasBorder: true)
          Text("Square").font(theme.typography.body.footnote)
        }
        VStack(spacing: theme.spacing.spacerS) {
          Avatar(content: .text("N"), size: .large, shape: .circle, hasBorder: false)
          Text("No Border").font(theme.typography.body.footnote)
        }
      }
      .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  // MARK: - Content Types

  private var contentTypesSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Content Types")
      HStack(spacing: theme.spacing.spacerXL) {
        VStack(spacing: theme.spacing.spacerS) {
          Avatar(content: .text("A"), size: .large, shape: .circle, hasBorder: true)
          Text("Text").font(theme.typography.body.footnote)
        }
        VStack(spacing: theme.spacing.spacerS) {
          Avatar(content: .systemImage("person.fill"), size: .large, shape: .circle, hasBorder: true)
          Text("System Icon").font(theme.typography.body.footnote)
        }
      }
      .foregroundStyle(theme.colorPalette.text.secondary)
    }
  }

  // MARK: - Helpers

  private func sectionLabel(_ text: String) -> some View {
    Text(text)
      .font(theme.typography.title.headline)
      .foregroundStyle(theme.colorPalette.text.primary)
  }
}
