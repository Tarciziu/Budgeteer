//
//  LocalDataBaseAssember+Models.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import SwiftData

extension LocalDataBaseAssembler {
  /// Type containing a list of all data models used by SwiftData in the app.
  ///
  /// - Note: This should serve as the single source of truth for generating the SwiftData Schema.
  static let appModels: [any PersistentModel.Type] = {
    [
      ReminderModel.self,
      TransactionModel.self
    ]
  }()
}
