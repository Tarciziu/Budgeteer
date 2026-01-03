//
//  ProfilePageUIMapper.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 27.09.2025.
//

import Foundation
import BTCore

struct ProfilePageUIMapper {
  func map() -> ProfilePageUIModel {
    ProfilePageUIModel(
      sections: [
        makeApperanceSection(),
        makeFeedbackSection(),
        makeTransactionsSection()
      ]
    )
  }

  // MARK: - Private Methods

  private func makeApperanceSection() -> ProfilePageUIModel.Section {
    let links = [
      ProfilePageUIModel.Link(
        title: Constants.appearanceTabChildTitle,
        subtitle: Constants.appearanceTabChildSubtitle,
        type: .theming
      )
    ]

    return ProfilePageUIModel.Section(
      title: Constants.appearanceTabTitle,
      subtitle: Constants.appearanceTabSubTitle,
      type: .appearance,
      links: links
    )
  }

  private func makeFeedbackSection() -> ProfilePageUIModel.Section {
    let links = [
      ProfilePageUIModel.Link(
        title: Constants.feedbackTabChildTitle,
        subtitle: nil,
        type: .suggestion
      )
    ]

    return ProfilePageUIModel.Section(
      title: Constants.feedbackTabTitle,
      subtitle: Constants.feedbackTabSubTitle,
      type: .feedback,
      links: links
    )
  }

  private func makeTransactionsSection() -> ProfilePageUIModel.Section {
    let links = [
      ProfilePageUIModel.Link(
        title: Constants.remindersTabChildTitle,
        subtitle: nil,
        type: .remindersConfiguration
      )
    ]

    return ProfilePageUIModel.Section(
      title: Constants.remindersTabTitle,
      subtitle: Constants.remindersTabSubTitle,
      type: .reminders,
      links: links
    )
  }
}

private extension ProfilePageUIMapper {
  private enum Constants {
    static let appearanceTabTitle =
    Strings.Budgeteer.singular("profile.appearanceSection.title")
    static let appearanceTabSubTitle =
    Strings.Budgeteer.singular("profile.appearanceSection.subtitle")
    static let appearanceTabChildTitle =
    Strings.Budgeteer.singular("profile.appearanceSection.child.Title")
    static let appearanceTabChildSubtitle =
    Strings.Budgeteer.singular("profile.appearanceSection.child.subtitle")

    static let feedbackTabTitle =
    Strings.Budgeteer.singular("profile.feedbackSection.title")
    static let feedbackTabSubTitle =
    Strings.Budgeteer.singular("profile.feedbackSection.subtitle")
    static let feedbackTabChildTitle =
    Strings.Budgeteer.singular("profile.feedbackSection.child.title")

    static let remindersTabTitle =
    Strings.Budgeteer.singular("profile.remindersSection.title")
    static let remindersTabSubTitle =
    Strings.Budgeteer.singular("profile.remindersSection.subtitle")
    static let remindersTabChildTitle =
    Strings.Budgeteer.singular("profile.remindersSection.child.title")
  }
}
