//
//  Container+AppLaunch.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import FactoryKit
import BTBusinessCore

extension Container {
  var appLaunchFailureViewModel: Factory<AppLaunchFailureViewModel> {
    self {
      AppLaunchFailureViewModel(getBudgetPlansUseCase: self.getBudgetPlansUseCase())
    }
  }
}
