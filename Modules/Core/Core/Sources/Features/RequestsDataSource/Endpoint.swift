//
//  Endpoint.swift
//  Core
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation

/// Type indicating an endpoint in a data request.
public protocol Endpoint {
  /// Unique identifier used to mimic the path to an endpoint.
  var id: EndpointPath { get }

  /// Executes the request associated with the endpoint
  /// - Parameter requestModel: The `Request` containing the necessary information to identify the endpoint and perform the operation.
  /// - Returns: The optional data model returned from the request.
  ///
  /// - Note: The data in the response is provided as an optional array of a generic type as the method needs to encapsulate
  /// all the operations done in a CRUD environment. For operations such as DELETE there is usually no return information.
  @discardableResult
  func executeRequest<R>(
    requestModel: Request
  ) async throws -> [R]? where R: DataSourceModel
}
