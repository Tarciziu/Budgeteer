//
//  Container.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2025.
//

import FactoryKit
import BTCore

// All dependencies for the app features should be added as an extension of the `Container` class.
// For more information see: https://github.com/hmlongco/Factory
extension Container {
  var dataSource: Factory<UserDataSource> {
    self { DefaultUserDataSource() }.shared
  }
}
