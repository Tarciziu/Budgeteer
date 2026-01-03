//
//  Container+Formatters.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 03.01.2026.
//

import FactoryKit
import BTCore

// MARK: - Date Formatters

extension Container {
  /// Single entity responsible for providing access to the date formatters store used frequently in the app.
  var defaultDateFormattersStore: Factory<DateFormatterStore> {
    self {
      DateFormatterStore()
    }
    .singleton
  }

  /// Single entity responsible for providing access to the service date formatters store,
  /// used only in operations related to data storage.
  var serviceDateFormattersStore: Factory<ServiceDateFormatterStore> {
    self {
      ServiceDateFormatterStore()
    }
    .singleton
  }
}

// MARK: - Number Formatters

extension Container {
  /// Single entity responsible for providing access to the numbers formatters store.
  var numbersFormattersStore: Factory<NumberFormatterStore> {
    self {
      NumberFormatterStore()
    }
    .singleton
  }
}
