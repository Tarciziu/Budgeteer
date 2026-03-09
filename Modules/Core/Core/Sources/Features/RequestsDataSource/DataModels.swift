//
//  DataModels.swift
//  Core
//
//  Created by Adrian-Zoltan Herczeg on 09.03.2026.
//

import Foundation

/// Type used to mark specific transfer models to be used by the data source.
public protocol DataSourceModel {}

/// Type describing the errors that can be identified at data source level.
public enum DataSourceError: Error {
  case internalInconsistency
  case missingDataSource
  case missingData
  case invalidDataSource
  case invalidHeaders
  case invalidRequest
}

/// Type indicating the main content of a request to the data source.
public typealias DataSourceRequestBody = any DataSourceModel

/// Type indicating the headers passed to a request to the data source.
public typealias RequestHeaders = [String: String]

/// Unique identifier for each requests to the data source.
public typealias EndpointPath = String

/// Type containing all content of a request to an ``Endpoint``.
public struct Request {
  public let id: EndpointPath
  public let body: DataSourceRequestBody?
  public let headers: RequestHeaders

  /// Creates a new `Request`
  /// - Parameters:
  ///   - id: The id of the endpoint to which the request should be forwared.
  ///   - body: The main data model used in the request.
  ///   - requestHeaders: Additional headers used in the request.
  public init(
    id: EndpointPath,
    body: DataSourceRequestBody? = nil,
    requestHeaders: RequestHeaders = [:]
  ) {
    self.id = id
    self.body = body
    self.headers = requestHeaders
  }
}
