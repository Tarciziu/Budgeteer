//
//  Container+BudgetPlans.swift
//  Budgeteer
//
//  Created by Adrian-Zoltan Herczeg on 06.09.2026.
//

import FactoryKit
import SwiftData
import BTCore
import BTCustomerExperience
import BTBusinessCore

extension Container {
  var createInitialPlanUseCase: Factory<CreateInitialPlanUseCase> {
    self { DefaultCreateInitialPlanUseCase(repository: self.budgetPlanRepository) }
      .shared
  }

  var createBudgetPlanUseCase: Factory<CreateBudgetPlanUseCase> {
    self { DefaultCreateBudgetPlanUseCase(repository: self.budgetPlanRepository) }
      .shared
  }

  var getBudgetPlansUseCase: Factory<GetBudgetPlansUseCase> {
    self { DefaultGetBudgetPlansUseCase(repository: self.budgetPlanRepository) }
      .shared
  }

  var getBudgetPlanUseCase: Factory<GetBudgetPlanUseCase> {
    self { DefaultGetBudgetPlanUseCase(repository: self.budgetPlanRepository) }
      .shared
  }

  private var budgetPlanRepository: BudgetPlanRepository {
    DefaultBudgetPlanRepository(dataSource: makeBudgetPlansDataSource())
  }

  private func makeBudgetPlansDataSource() -> DataSource {
    let endpoints = [
      makeCreateBudgetPlanEndpoint(),
      makeGetBudgetPlansEndpoint(),
      makeGetBudgetPlanEndpoint()
    ]

    return LocalDataSource(endpoints: endpoints)
  }
}

// MARK: - Endpoints

private extension Container {
  private func makeCreateBudgetPlanEndpoint() -> Endpoint {
    return CreateBudgetPlanEndpoint(
      id: BudgetPlanEndpotsID.createBudgetPlan.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeGetBudgetPlansEndpoint() -> Endpoint {
    return GetBudgetPlansEndpoint(
      id: BudgetPlanEndpotsID.getBudgetPlans.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }

  private func makeGetBudgetPlanEndpoint() -> Endpoint {
    return GetBudgetPlanEndpoint(
      id: BudgetPlanEndpotsID.getBudgetPlan.rawValue,
      modelContainer: dataSourceAssember().modelContainer
    )
  }
}
