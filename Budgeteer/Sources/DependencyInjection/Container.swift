//
//  Container.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2025.
//

import FactoryKit
import BTCore
import BTCoreUI

/// All dependencies for the app features should be added as an extension of the `Container` class.
/// For more information see: https://github.com/hmlongco/Factory
extension Container {
  var dataSource: Factory<UserDataSource> {
    self { DefaultUserDataSource() }.shared
  }

  var userPreferences: Factory<UserPreferences> {
    self { DefaultUserPreferences() }.shared
  }

  // MARK: - Theme

  var theme: Factory<BTTheme> {
    self {
      BTTheme(
        typography: Typography.mainTypography,
        spacing: Spacing.mainSpacing,
        iconSize: IconSize.mainIconSize,
        colorPalette: .appColorPalette,
        imageCatalog: .appImageCatalog,
        shimmer: .mainShimmer,
        borderRadius: .mainBorderRadius
      )
    }
    .singleton
  }

  var localNotificationsHandler: Factory<LocalNotificationsHandler> {
    self { LocalNotificationsHandler() }
      .singleton
  }

  var appLaunchViewModel: Factory<AppLaunchViewModel> {
    self {
      AppLaunchViewModel(notificationsHandler: self.localNotificationsHandler())
    }
    .shared
  }

  var mainWindowViewModel: Factory<MainWindowViewModel> {
    self { MainWindowViewModel() }.shared
  }
}
