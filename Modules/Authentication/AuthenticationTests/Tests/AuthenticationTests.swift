//
//  AuthenticationTests.swift
//  AuthenticationTests
//
//  Created by Tarciziu Gologan on 12.10.2025.
//

import Testing

@testable import BTAuthentication
import AppTestingGround

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
