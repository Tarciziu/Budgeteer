//
//  LocalDataBaseAssembler.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 17.03.2026.
//

import Foundation
import SwiftData

/// Main entity used to assemble the local database.
final class LocalDataBaseAssembler {
  // MARK: - Internal Properties

  let modelContainer: ModelContainer

  // MARK: - Init

  init() {
    let schema = Schema(Self.appModels)
    let configuration = ModelConfiguration.init(schema: schema)
    do {
      modelContainer = try ModelContainer(for: schema, configurations: configuration)
    } catch {
      fatalError("Failed to initialise local data base")
    }
  }
}
