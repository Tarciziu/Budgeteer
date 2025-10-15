//
//  CoreTests.swift
//  CoreTests
//
//  Created by Tarciziu Gologan on 30.08.2025.
//

import Testing

@testable import BTCore
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
