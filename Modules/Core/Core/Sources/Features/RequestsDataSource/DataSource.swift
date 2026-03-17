//
//  DataSource.swift
//  Core
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation

/// Type indicating the data source containing all endpoints for a feature.
public protocol DataSource {
  /// List of all endpoints accessible to the data source.
  var endpoints: [Endpoint] { get }

  /// Execute a reqeust to the data source with the given parameters.
  func executeRequest<R>(
    request: Request
  ) async throws -> [R]? where R: DataSourceModel
}
