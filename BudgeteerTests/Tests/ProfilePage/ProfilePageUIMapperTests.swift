//
//  ProfilePageUIMapperTests.swift
//  CustomerExperienceTests
//
//  Created by Adrian-Zoltan Herczeg on 02.01.2026.
//

import Testing

@testable import Budgeteer

struct ProfilePageUIMapperTests {
  // MARK: - Constants

  private enum Constants {
    static let expectedLinks: [ProfilePageUIModel.LinkType] = [
      .theming,
      .suggestion,
      .remindersConfiguration
    ]
  }

  // MARK: - Private Properties

  private let mapper = ProfilePageUIMapper()

  // MARK: - Tests

  @Test("Tests if the list of links displayed in the profile page is correct")
  func test_Map_CorrectListOfLinksDisplayed() {
    // Given
    let output = mapper.map()

    // When
    let outputLinks: [ProfilePageUIModel.LinkType] =
    output.sections.reduce([]) { partialResult, current in
      let sectionLinks = current.links.map(\.type)
      var newLinks = partialResult
      newLinks.append(contentsOf: sectionLinks)
      return newLinks
    }

    // Then
    #expect(outputLinks == Constants.expectedLinks)
  }
}
