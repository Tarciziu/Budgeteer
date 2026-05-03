//
//  ChipsSampleScreen.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 01/05/2026.
//

import SwiftUI
import BTCoreUI

struct ChipsSampleScreen: View {
  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme

  // MARK: - State Properties

  @State private var selectedChips: Set<String> = ["Option A"]

  // MARK: - Body

  var body: some View {
    ScrollView {
      VStack(spacing: theme.spacing.spacerXXL) {
        chipButtonSection
        chipGroupSection
        horizontalChipBarSection
      }
    }
    .contentMargins(theme.spacing.spacerL)
    .scrollIndicators(.hidden)
    .navigationBar(NavigationBarConfiguration(title: "Chips"))
  }

  // MARK: - Chip Button

  private var chipButtonSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Chip Buttons")
      HStack(spacing: theme.spacing.spacerS) {
        ChipButton(content: .init(label: "Selected", isSelected: true) {})
        ChipButton(content: .init(label: "Unselected", isSelected: false) {})
        ChipButton(content: .init(label: "With Icon", isSelected: true, trailingIcon: "xmark") {})
      }
    }
  }

  // MARK: - Chip Group

  private var chipGroupSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Chip Group (FlowLayout)")
      let chips = ["Option A", "Option B", "Option C", "Long Option D", "E", "Option F"].map { label in
        ChipButton.Content(
          label: label,
          isSelected: selectedChips.contains(label)
        ) {
          toggleChip(label)
        }
      }
      ChipGroup(label: "Select Options", chips: chips)
    }
  }

  // MARK: - Horizontal Chip Bar

  private var horizontalChipBarSection: some View {
    VStack(alignment: .leading, spacing: theme.spacing.spacerM) {
      sectionLabel("Horizontal Chip Bar")
      HorizontalChipBar(chips: [
        .init(label: "All", isSelected: true) {},
        .init(label: "Recent", isSelected: false) {},
        .init(label: "Popular", isSelected: false) {},
        .init(label: "Favorites", isSelected: false) {},
        .init(label: "Archived", isSelected: false) {}
      ])
      sectionLabel("With Pinned Chip")
      HorizontalChipBar(
        pinnedChips: [.init(label: "Filter", isSelected: true, trailingIcon: "slider.horizontal.3") {}],
        chips: [
          .init(label: "Tag 1", isSelected: true, trailingIcon: "xmark") {},
          .init(label: "Tag 2", isSelected: true, trailingIcon: "xmark") {},
          .init(label: "Tag 3", isSelected: true, trailingIcon: "xmark") {}
        ]
      )
    }
  }

  // MARK: - Helpers

  private func toggleChip(_ label: String) {
    if selectedChips.contains(label) {
      selectedChips.remove(label)
    } else {
      selectedChips.insert(label)
    }
  }

  private func sectionLabel(_ text: String) -> some View {
    Text(text)
      .font(theme.typography.title.headline)
      .foregroundStyle(theme.colorPalette.text.primary)
  }
}
