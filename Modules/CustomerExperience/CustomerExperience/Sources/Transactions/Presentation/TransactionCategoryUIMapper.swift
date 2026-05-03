//
//  TransactionCategoryUIMapper.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 03/05/2026.
//

import Foundation
import BTCore

struct TransactionCategoryUIMapper {
  // MARK: - Nested Types

  private enum Constants {
    static let categorySeparator = ", "
  }

  // MARK: - DM to UIModel

  func map(_ category: TransactionCategoryDM) -> TransactionCategoryUIModel {
    let type = mapType(category)
    return TransactionCategoryUIModel(type: type, title: mapLabel(type))
  }

  func map(_ categories: [TransactionCategoryDM]) -> [TransactionCategoryUIModel] {
    categories.map { map($0) }
  }

  func allCategories() -> [TransactionCategoryUIModel] {
    TransactionCategoryUIModel.CategoryType.allCases.map { type in
      TransactionCategoryUIModel(type: type, title: mapLabel(type))
    }
  }

  func mapCategoriesLabel(_ categories: [TransactionCategoryDM]) -> String {
    categories.map { map($0).title }.joined(separator: Constants.categorySeparator)
  }

  // MARK: - UIModel to DM

  func map(_ category: TransactionCategoryUIModel) -> TransactionCategoryDM {
    mapDM(category.type)
  }

  func map(_ categories: Set<TransactionCategoryUIModel>) -> [TransactionCategoryDM] {
    categories.map { map($0) }
  }

  func mapFromLabel(_ label: String) -> TransactionCategoryDM? {
    TransactionCategoryDM.allCases.first { category in
      mapLabel(mapType(category)) == label
    }
  }

  func mapCategoriesFromLabel(_ label: String) -> [TransactionCategoryDM] {
    label.split(separator: Constants.categorySeparator).compactMap { mapFromLabel(String($0)) }
  }

  // MARK: - Private Methods

  private func mapType(_ category: TransactionCategoryDM) -> TransactionCategoryUIModel.CategoryType {
    switch category {
    case .groceries: .groceries
    case .bills: .bills
    case .entertainment: .entertainment
    case .salary: .salary
    case .transport: .transport
    case .health: .health
    case .shopping: .shopping
    case .other: .other
    }
  }

  private func mapDM(_ type: TransactionCategoryUIModel.CategoryType) -> TransactionCategoryDM {
    switch type {
    case .groceries: .groceries
    case .bills: .bills
    case .entertainment: .entertainment
    case .salary: .salary
    case .transport: .transport
    case .health: .health
    case .shopping: .shopping
    case .other: .other
    }
  }

  private func mapLabel(_ type: TransactionCategoryUIModel.CategoryType) -> String {
    Strings.CustomerExperience.singular("transactions.category.\(type.rawValue)")
  }
}
