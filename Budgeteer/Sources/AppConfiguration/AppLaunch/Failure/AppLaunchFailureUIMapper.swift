//
//  AppLaunchFailureUIMapper.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Foundation
import BTCore

/// Builds the content for ``AppLaunchFailureUIModel``.
struct AppLaunchFailureUIMapper {
  func map() -> AppLaunchFailureUIModel {
    AppLaunchFailureUIModel(
      title: LocalizedStrings.title,
      message: LocalizedStrings.message,
      retryButtonTitle: LocalizedStrings.retryButtonTitle
    )
  }
}

private extension AppLaunchFailureUIMapper {
  enum LocalizedStrings {
    static let title = Strings.Budgeteer.singular("appLaunch.failure.title")
    static let message = Strings.Budgeteer.singular("appLaunch.failure.message")
    static let retryButtonTitle = Strings.Budgeteer.singular("appLaunch.failure.retry")
  }
}
