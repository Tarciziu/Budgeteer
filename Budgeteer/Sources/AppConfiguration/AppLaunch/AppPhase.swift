//
//  AppPhase.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 09.09.2025.
//

import Foundation

/// Type representing different phases of the app.
enum AppPhase: Equatable {
  case initialisation
  case initialisationFailure
  case launching
  case newCustomerSetup
  case mainApp
}
