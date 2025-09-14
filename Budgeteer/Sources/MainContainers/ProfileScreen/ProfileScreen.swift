//
//  ProfileScreen.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2025.
//

import SwiftUI
import BTCoreUI

struct ProfileScreen: View {
  private let navBarConfig: NavigationBarConfiguration

  init(config: NavigationBarConfiguration) {
    self.navBarConfig = config
  }

  var body: some View {
    Text("Profile Screen")
      .navigationBar(navBarConfig)
  }
}
