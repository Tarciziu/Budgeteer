//
//  DefaultBudgetPlanRepository.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import BTCore
import BTBusinessCore

/// Default implementation of ``BudgetPlanRepository``.
final public class DefaultBudgetPlanRepository: BudgetPlanRepository {
  // MARK: - Nested Types

  private enum Constants {
    static let budgetPlanIdKey: String = "bpId"
  }

  // MARK: - Private Properties

  private let mapper = BudgetPlansDataMapper()
  private let dataSource: DataSource

  // MARK: - Init

  /// Initializes the default implementation of ``BudgetPlanRepository``.
  /// - Parameter dataSource: The data source used to execute requests.
  public init(dataSource: DataSource) {
    self.dataSource = dataSource
  }

  // MARK: - BudgetPlanRepository conformance

  public func getBudgetPlans() async throws -> [BudgetPlanDM] {
    let request = Request(id: BudgetPlanEndpotsID.getBudgetPlans.rawValue)
    let result: [BudgetPlanDTO]? = try await dataSource.executeRequest(request: request)
    return mapper.map(result ?? [])
  }

  public func getBudgetPlan(id: String) async throws -> BudgetPlanDM {
    let headers: [String: String] = [Constants.budgetPlanIdKey: id]
    let request = Request(id: BudgetPlanEndpotsID.getBudgetPlan.rawValue, requestHeaders: headers)
    let result: [BudgetPlanDTO]? = try await dataSource.executeRequest(request: request)
    guard let budgetPlanDTO = result?.first else {
      throw DataSourceError.missingData
    }
    return mapper.map(budgetPlanDTO)
  }

  @discardableResult
  public func storeBudgetPlan(_ creationDM: BudgetPlanCreationDM) async throws -> BudgetPlanDM {
    let requestBody = mapper.map(creationDM)
    let requestId = BudgetPlanEndpotsID.createBudgetPlan.rawValue
    let request = Request(id: requestId, body: requestBody)
    let result: [BudgetPlanDTO]? = try await dataSource.executeRequest(request: request)
    guard let budgetPlanDTO = result?.first else {
      throw DataSourceError.missingData
    }
    return mapper.map(budgetPlanDTO)
  }
}
