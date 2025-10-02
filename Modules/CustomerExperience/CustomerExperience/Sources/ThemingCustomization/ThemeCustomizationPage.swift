//
//  ThemeCustomizationPage.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import SwiftUI
import BTCoreUI

public struct ThemeCustomizationPage: View {
  private let navigationBar: NavigationBarConfiguration

  public init(navigationBar: NavigationBarConfiguration) {
    self.navigationBar = navigationBar
  }

  public var body: some View {
    Text("ThemeCustomizationPage")
      .navigationBar(navigationBar)
  }
}
