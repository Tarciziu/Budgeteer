//
//  AppLaunchFailureUIMapperTests.swift
//  BudgeteerTests
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import Testing

@testable import Budgeteer

struct AppLaunchFailureUIMapperTests {
  private enum Constants {
    static let expectedUIModel = AppLaunchFailureUIModel(
      title: "Something went wrong",
      message: "We couldn't load your data. Please try again.",
      retryButtonTitle: "Try again"
    )
  }

  private let mapper = AppLaunchFailureUIMapper()

  @Test("The initialisation-failure mapper produces the expected content.")
  func test_Map_ProducesExpectedUIModel() {
    #expect(mapper.map() == Constants.expectedUIModel)
  }
}
