//
//  TransactionFilterStrings.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 25/08/2026.
//

import BTCore

/// Shared localized strings used by transaction filter components.
  enum TransactionFilterStrings {
    static let filterLabel = Strings.CustomerExperience.singular("transactions.filters.filterLabel")
    static let searchPlaceholder = Strings.CustomerExperience.singular("transactions.filters.searchPlaceholder")
    static let filtersTitle = Strings.CustomerExperience.singular("transactions.filters.title")
    static let dateFilterLabel = Strings.CustomerExperience.singular("transactions.filters.dateFilterLabel")
    static let categoryFilterLabel = Strings.CustomerExperience.singular("transactions.filters.categoryFilterLabel")
    static let noneDateLabel = Strings.CustomerExperience.singular("transactions.filters.none")
    static let beforeLabel = Strings.CustomerExperience.singular("transactions.filters.before")
    static let afterLabel = Strings.CustomerExperience.singular("transactions.filters.after")
    static let betweenLabel = Strings.CustomerExperience.singular("transactions.filters.between")
    static let startDateLabel = Strings.CustomerExperience.singular("transactions.filters.startDate")
    static let endDateLabel = Strings.CustomerExperience.singular("transactions.filters.endDate")
    static let applyLabel = Strings.CustomerExperience.singular("transactions.filters.apply")
    static let resetLabel = Strings.CustomerExperience.singular("transactions.filters.reset")
  }
