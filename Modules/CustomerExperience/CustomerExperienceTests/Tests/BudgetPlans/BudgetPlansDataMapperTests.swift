//
//  BudgetPlansDataMapperTests.swift
//  CustomerExperienceTests
//
//  Created by Tarciziu Gologan on 30/08/2026.
//

import Foundation
import Testing
import BTBusinessCore
@testable import BTCustomerExperience

struct BudgetPlansDataMapperTests {
  // MARK: - Private Properties

  private let mapper = BudgetPlansDataMapper()

  // MARK: - DTO to DM

  @Test("Maps every scalar field of a budget plan DTO to the domain model")
  func test_Map_DTOToDM_MapsScalarFields() {
    // Given
    let dto = BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-9", name: "Trip", currency: "EUR")

    // When
    let result = mapper.map(dto)

    // Then
    #expect(result.id == "bp-9")
    #expect(result.name == "Trip")
    #expect(result.openingDate == BudgetPlanDataGenerator.openingDate)
    #expect(result.currency == .eur)
    #expect(result.periodStartDay == .day05)
    #expect(result.recurrentBalance == 4_200)
  }

  @Test("Maps the nested monthly budgets of a budget plan DTO")
  func test_Map_DTOToDM_MapsNestedMonthlyBudgets() throws {
    // Given
    let dto = BudgetPlanDataGenerator.budgetPlanDTO(
      monthlyBudgets: [
        BudgetPlanDataGenerator.monthlyBudgetDTO(id: "mb-1"),
        BudgetPlanDataGenerator.monthlyBudgetDTO(id: "mb-2")
      ]
    )

    // When
    let result = mapper.map(dto)

    // Then
    #expect(result.monthlyBudgets.map(\.id) == ["mb-1", "mb-2"])
    let first = try #require(result.monthlyBudgets.first)
    #expect(first.startingBalance == 1_000)
    #expect(first.periodStartDate == BudgetPlanDataGenerator.periodStartDate)
    #expect(first.periodEndDate == BudgetPlanDataGenerator.periodEndDate)
  }

  @Test("Maps a list of budget plan DTOs preserving order")
  func test_Map_DTOListToDMList_PreservesOrder() {
    // Given
    let dtos = [
      BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-1"),
      BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-2"),
      BudgetPlanDataGenerator.budgetPlanDTO(id: "bp-3")
    ]

    // When
    let result = mapper.map(dtos)

    // Then
    #expect(result.map(\.id) == ["bp-1", "bp-2", "bp-3"])
  }

  @Test("Resolves the currency code of a budget plan DTO", arguments: [
    ("EUR", CurrencyDM.eur),
    ("USD", CurrencyDM.usd)
  ])
  func test_Map_DTOToDM_ResolvesKnownCurrency(code: String, expected: CurrencyDM) {
    // Given
    let dto = BudgetPlanDataGenerator.budgetPlanDTO(currency: code)

    // When
    let result = mapper.map(dto)

    // Then
    #expect(result.currency == expected)
  }

  @Test("Falls back to the default currency for an unknown currency code")
  func test_Map_DTOToDM_FallsBackToDefaultCurrency() {
    // Given
    let dto = BudgetPlanDataGenerator.budgetPlanDTO(currency: "GBP")

    // When
    let result = mapper.map(dto)

    // Then
    #expect(result.currency == CurrencyDM.defaultCurrency)
  }

  // MARK: - DM to DTO

  @Test("Maps a creation model to a request DTO including the currency code")
  func test_Map_CreationDMToRequestDTO_MapsScalarFields() {
    // Given
    let creationDM = BudgetPlanDataGenerator.budgetPlanCreationDM(currency: .usd)

    // When
    let result = mapper.map(creationDM)

    // Then
    #expect(result.name == "Household")
    #expect(result.openingDate == BudgetPlanDataGenerator.openingDate)
    #expect(result.currency == "USD")
    #expect(result.periodStartDay == .day05)
    #expect(result.recurrentBalance == 4_200)
  }

  @Test("Maps the first monthly budget of a creation model")
  func test_Map_CreationDMToRequestDTO_MapsMonthlyBudget() {
    // Given
    let creationDM = BudgetPlanDataGenerator.budgetPlanCreationDM()

    // When
    let result = mapper.map(creationDM)

    // Then
    #expect(result.monthlyBudget.startingBalance == 1_000)
    #expect(result.monthlyBudget.periodStartDate == BudgetPlanDataGenerator.periodStartDate)
    #expect(result.monthlyBudget.periodEndDate == BudgetPlanDataGenerator.periodEndDate)
  }

  // MARK: - Period day

  @Test("Maps the period day of a budget plan DTO to the matching domain case", arguments: [
    (PeriodDayDTO.day01, PeriodDayDM.day01),
    (PeriodDayDTO.day08, PeriodDayDM.day08),
    (PeriodDayDTO.day28, PeriodDayDM.day28),
    (PeriodDayDTO.lastDayOfMonth, PeriodDayDM.lastDayOfMonth)
  ])
  func test_Map_DTOToDM_MapsPeriodDay(dto: PeriodDayDTO, expected: PeriodDayDM) {
    // Given
    let plan = BudgetPlanDataGenerator.budgetPlanDTO(periodStartDay: dto)

    // When
    let result = mapper.map(plan)

    // Then
    #expect(result.periodStartDay == expected)
  }

  @Test("Maps the period day of a creation model to the matching request DTO case", arguments: [
    (PeriodDayDM.day01, PeriodDayDTO.day01),
    (PeriodDayDM.day08, PeriodDayDTO.day08),
    (PeriodDayDM.day28, PeriodDayDTO.day28),
    (PeriodDayDM.lastDayOfMonth, PeriodDayDTO.lastDayOfMonth)
  ])
  func test_Map_CreationDMToRequestDTO_MapsPeriodDay(domainModel: PeriodDayDM, expected: PeriodDayDTO) {
    // Given
    let creationDM = BudgetPlanDataGenerator.budgetPlanCreationDM(periodStartDay: domainModel)

    // When
    let result = mapper.map(creationDM)

    // Then
    #expect(result.periodStartDay == expected)
  }

  @Test("Every period day survives a DTO -> domain -> DTO round-trip")
  func test_Map_PeriodDay_RoundTripsForEveryCase() {
    for day in PeriodDayDTO.allCases {
      // Given
      let plan = BudgetPlanDataGenerator.budgetPlanDTO(periodStartDay: day)

      // When: DTO -> domain (mapper.map(BudgetPlanDTO)) then domain -> DTO (mapper.map(BudgetPlanCreationDM))
      let domainDay = mapper.map(plan).periodStartDay
      let creationDM = BudgetPlanDataGenerator.budgetPlanCreationDM(periodStartDay: domainDay)
      let roundTripped = mapper.map(creationDM).periodStartDay

      // Then
      #expect(roundTripped == day)
    }
  }
}
