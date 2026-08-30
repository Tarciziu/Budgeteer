//
//  TransactionDetailsViewModel+Localization.swift
//  CustomerExperience
//
//  Created by Tarciziu Gologan on 02/04/2026.
//

import BTCore

extension TransactionDetailsViewModel {
  struct LocalizedStrings {
    let titleLabel = Strings.CustomerExperience.singular("transactions.details.titleLabel")
    let descriptionLabel = Strings.CustomerExperience.singular("transactions.details.descriptionLabel")
    let amountLabel = Strings.CustomerExperience.singular("transactions.details.amountLabel")
    let categoryLabel = Strings.CustomerExperience.singular("transactions.details.categoryLabel")
    let dateLabel = Strings.CustomerExperience.singular("transactions.details.dateLabel")
    let saveActionLabel = Strings.CustomerExperience.singular("transactions.details.saveActionLabel")
    let updateActionLabel = Strings.CustomerExperience.singular("transactions.details.updateActionLabel")
    let screenTitle = Strings.CustomerExperience.singular("transactions.details.screenTitle")
    let validationAlertTitle =
    Strings.CustomerExperience.singular("transactions.alert.missingInformation.title")
    let missingCategoryMessage =
    Strings.CustomerExperience.singular("transactions.alert.missingInformation.description")
    let validationAlertDismissTitle = Strings.CustomerExperience.singular("generalStrings.ok")
  }
}
