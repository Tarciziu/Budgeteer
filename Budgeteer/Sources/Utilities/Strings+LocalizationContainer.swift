//
//  Strings+LocalizationContainer.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 27.09.2025.
//

import Foundation
import BTCore

extension Strings {
  typealias Budgeteer = LocalizedStrings<AppLocalizationContainer>

  final class AppLocalizationContainer: LocalizationContainer {
    static let localizationBundle = Bundle(for: AppLocalizationContainer.self)
    static let localizationTable: String? = "Localizable"

    private init() {}
  }
}
