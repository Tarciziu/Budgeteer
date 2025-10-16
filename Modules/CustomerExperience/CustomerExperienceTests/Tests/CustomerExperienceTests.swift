//
//  CustomerExperienceTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 30.09.2025.
//

import Testing

import AppTestingGround
@testable import BTCustomerExperience

struct CoreTests {
  @Test(
    "Flaky test",
    .tags(.flaky)
  )
  func flakyTest() {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
  }

  @Test(
    "Critical test",
    .tags(.critical)
  )
  func criticalTest() {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
  }

  @Test("Normal test")
  func normalTest() {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
  }
}
