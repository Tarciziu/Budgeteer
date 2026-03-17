//
//  LocalDataSource.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation
import BTCore
import SwiftData
import BTCustomerExperience

/// Implementation of the `DataSource` for local level persistency.
class LocalDataSource: DataSource {
  // MARK: - DataSource Properties

  let endpoints: [any Endpoint]

  // MARK: - Init

  init(endpoints: [any Endpoint]) {
    self.endpoints = endpoints
  }

  // MARK: - DataSource Methods

  func executeRequest<R>(
    request: Request
  ) async throws -> [R]? where R: DataSourceModel {
    let endpoint = endpoints.first {
      $0.id == request.id
    }

    guard let endpoint else {
      throw DataSourceError.invalidRequest
    }
    return try await endpoint.executeRequest(requestModel: request)
  }
}
