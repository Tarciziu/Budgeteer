//
//  BudgetPlansDataMapper.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import BTBusinessCore

struct BudgetPlansDataMapper {
  // MARK: - Private Properties

  private let currencyMapper = CurrencyMapper()

  // MARK: - DTO to DM

  func map(_ budgetPlanDTOs: [BudgetPlanDTO]) -> [BudgetPlanDM] {
    budgetPlanDTOs.map(map(_:))
  }

  func map(_ budgetPlan: BudgetPlanDTO) -> BudgetPlanDM {
    BudgetPlanDM(
      id: budgetPlan.id,
      name: budgetPlan.name,
      openingDate: budgetPlan.openingDate,
      currency: currencyMapper.map(currency: budgetPlan.currency) ?? CurrencyDM.defaultCurrency,
      periodStartDay: map(budgetPlan.periodStartDay),
      recurrentBalance: budgetPlan.recurrentBalance,
      monthlyBudgets: budgetPlan.monthlyBudgets.map(map(_:))
    )
  }

  // MARK: - DM to DTO

  func map(_ creationDM: BudgetPlanCreationDM) -> BudgetPlanCreationRequestDTO {
    BudgetPlanCreationRequestDTO(
      name: creationDM.name,
      openingDate: creationDM.openingDate,
      currency: currencyMapper.map(currency: creationDM.currency),
      periodStartDay: map(creationDM.periodStartDay),
      recurrentBalance: creationDM.recurrentBalance,
      monthlyBudget: map(creationDM.monthlyBudget)
    )
  }

  // MARK: - Private Methods

  private func map(_ monthlyBudget: MonthlyBudgetDTO) -> MonthlyBudgetDM {
    MonthlyBudgetDM(
      id: monthlyBudget.id,
      startingBalance: monthlyBudget.startingBalance,
      periodStartDate: monthlyBudget.periodStartDate,
      periodEndDate: monthlyBudget.periodEndDate
    )
  }

  private func map(_ monthlyBudget: MonthlyBudgetCreationDM) -> MonthlyBudgetCreationRequestDTO {
    MonthlyBudgetCreationRequestDTO(
      startingBalance: monthlyBudget.startingBalance,
      periodStartDate: monthlyBudget.periodStartDate,
      periodEndDate: monthlyBudget.periodEndDate
    )
  }

  private func map(_ periodDay: PeriodDayDTO) -> PeriodDayDM {
    Self.domainByDTO[periodDay] ?? .lastDayOfMonth
  }

  private func map(_ periodDay: PeriodDayDM) -> PeriodDayDTO {
    Self.dtoByDomain[periodDay] ?? .lastDayOfMonth
  }

  // MARK: - Period day lookup tables

  private static let domainByDTO: [PeriodDayDTO: PeriodDayDM] = [
    .day01: .day01, .day02: .day02, .day03: .day03, .day04: .day04, .day05: .day05,
    .day06: .day06, .day07: .day07, .day08: .day08, .day09: .day09, .day10: .day10,
    .day11: .day11, .day12: .day12, .day13: .day13, .day14: .day14, .day15: .day15,
    .day16: .day16, .day17: .day17, .day18: .day18, .day19: .day19, .day20: .day20,
    .day21: .day21, .day22: .day22, .day23: .day23, .day24: .day24, .day25: .day25,
    .day26: .day26, .day27: .day27, .day28: .day28, .lastDayOfMonth: .lastDayOfMonth
  ]

  private static let dtoByDomain: [PeriodDayDM: PeriodDayDTO] =
    Dictionary(uniqueKeysWithValues: domainByDTO.map { ($0.value, $0.key) })
}
