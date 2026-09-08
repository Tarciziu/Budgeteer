//
//  SwiftTestingMockAssertion.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 08.09.2026.
//

import Testing
import InstantMock

/// Routes InstantMock expectation / rejection failures (which are `XCTFail` based, and therefore
/// invisible to Swift Testing) into a Swift Testing issue, so `mock.verify()` actually fails a
/// `@Test`.
///
/// A `Mock` subclass opts in by forwarding ``SwiftTestingMock/factory`` to `super.init(_:)`.
struct SwiftTestingMockAssertion: InstantMock.Assertion {
  func success(file: StaticString?, line: UInt?) {}

  func fail(_ description: String?, file: StaticString?, line: UInt?) {
    Issue.record(Comment(rawValue: description ?? "InstantMock expectation was not satisfied"))
  }
}

enum SwiftTestingMock {
  /// `ExpectationFactory` whose expectations report failures through Swift Testing.
  static var factory: InstantMock.ExpectationFactory { SwiftTestingExpectationFactory() }
}

private final class SwiftTestingExpectationFactory: InstantMock.ExpectationFactory {
  func expectation(withStub stub: InstantMock.Stub) -> InstantMock.Expectation {
    InstantMock.Expectation(withStub: stub, reject: false, assertion: SwiftTestingMockAssertion())
  }

  func rejection(withStub stub: InstantMock.Stub) -> InstantMock.Expectation {
    InstantMock.Expectation(withStub: stub, reject: true, assertion: SwiftTestingMockAssertion())
  }
}
