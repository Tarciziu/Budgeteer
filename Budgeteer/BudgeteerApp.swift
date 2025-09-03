//
//  BudgeteerApp.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 20.08.2025.
//

import SwiftUI
import FactoryKit

@main
struct BudgeteerApp: App {
  // Example of accessing a dependency.
  let dataSource = Container.shared.dataSource()

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
