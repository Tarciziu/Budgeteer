//
//  AppLocalizationContainer.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 14.03.2026.
//


import Foundation
import BTCore

extension Strings {
  typealias CustomerExperience = LocalizedStrings<AppLocalizationContainer>

  final class AppLocalizationContainer: LocalizationContainer {
    static let localizationBundle = Bundle(for: AppLocalizationContainer.self)
    static let localizationTable: String? = "Localizable"

    private init() {}
  }
}
