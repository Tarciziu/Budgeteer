//
//  Container+LocalDataSource.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import SwiftData
import FactoryKit
import BTBusinessCore
import BTCustomerExperience

extension Container {
  var dataSourceAssember: Factory<LocalDataBaseAssembler> {
    self {
      LocalDataBaseAssembler()
    }
    .singleton
  }
}
