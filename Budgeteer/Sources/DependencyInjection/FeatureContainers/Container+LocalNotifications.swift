//
//  Container+LocalNotifications.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 11/04/2026.
//

import Foundation
import FactoryKit
import BTBusinessCore

extension Container {
  static let appNotificationsGroupIdentifier = "Budgeteer"
}

extension Container {
  static let defaultNotificationsAppConfig = DefaultLocalNotificationsManager.Config(
    appNotificationsGroupIdentifier: appNotificationsGroupIdentifier
  )

  var localNotificationsManager: Factory<LocalNotificationsManager> {
    self {
      DefaultLocalNotificationsManager(config: Self.defaultNotificationsAppConfig)
    }
    .singleton
  }
}
