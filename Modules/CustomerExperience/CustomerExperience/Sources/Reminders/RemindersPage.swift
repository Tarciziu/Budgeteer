//
//  RemindersPage.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import SwiftUI
import BTCoreUI

public struct RemindersPage: View {
  private let navigationBarConfig: NavigationBarConfiguration

  public init(navigationBar: NavigationBarConfiguration) {
    self.navigationBarConfig = navigationBar
  }

  public var body: some View {
    Text("RemindersPage")
      .navigationBar(navigationBarConfig)
  }
}
