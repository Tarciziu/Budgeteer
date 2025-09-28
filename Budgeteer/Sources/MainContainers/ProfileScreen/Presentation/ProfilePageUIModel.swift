//
//  ProfilePageUIModel.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 27.09.2025.
//

import Foundation

struct ProfilePageUIModel {
  let sections: [Section]
}

extension ProfilePageUIModel {
  struct Section {
    let title: String
    let subtitle: String?
    let type: SectionType
    let links: [Link]
  }

  struct Link {
    let title: String
    let subtitle: String?
    let type: LinkType
  }

  enum SectionType {
    case feedback
    case reminders
    case appearance
  }

  enum LinkType {
    case suggestion
    case remindersConfiguration
    case theming
  }
}
