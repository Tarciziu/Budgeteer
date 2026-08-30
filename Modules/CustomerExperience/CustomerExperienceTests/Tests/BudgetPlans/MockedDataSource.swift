//
//  MockedDataSource.swift
//  CustomerExperienceTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import InstantMock
import BTCore

/// InstantMock based test double for ``DataSource``.
///
/// Stub the response with `stub().call(...)` combined with `andReturn(...)` / `andThrow(...)`.
/// The issued requests are recorded in ``executedRequests`` for inspection – call
/// ``clearRecordedRequests()`` after configuring the stubs to drop the request produced during registration.
final class MockedDataSource: Mock, DataSource {
  private(set) var executedRequests: [Request] = []

  var lastExecutedRequest: Request? { executedRequests.last }

  var endpoints: [Endpoint] { [] }

  func executeRequest<R>(request: Request) async throws -> [R]? where R: DataSourceModel {
    executedRequests.append(request)
    return try callThrowing()
  }

  func clearRecordedRequests() {
    executedRequests.removeAll()
  }
}

/// Error used to stub failing data source calls.
enum DataSourceTestError: Error {
  case stubbed
}
