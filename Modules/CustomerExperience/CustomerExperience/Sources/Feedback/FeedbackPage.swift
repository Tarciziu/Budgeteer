//
//  FeedbackPage.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 01.10.2025.
//

import SwiftUI
import BTCoreUI

public struct FeedbackPage: View {
  private let navigationBar: NavigationBarConfiguration

  public init(navigationBar: NavigationBarConfiguration) {
    self.navigationBar = navigationBar
  }

  public var body: some View {
    Text("FeedbackPage")
      .navigationBar(navigationBar)
  }
}
