//
//  String+ContentManipulation.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 27.12.2025.
//

import Foundation

extension String {
  /// Replaces first occurrence of a given substring.
  /// - Parameters:
  ///   - replacedString: The string to be replaced.
  ///   - replacementString: The replacement string.
  ///   - options: Comparison options to be used for searching first occurrence.
  /// - Returns: Resulted string after replacement.
  public func replacingFirstOccurrence(
    of replacedString: String,
    with replacementString: String,
    options: String.CompareOptions = []
  ) -> String {
    guard let range = range(of: replacedString, options: options, range: nil, locale: nil) else {
      return self
    }
    return replacingCharacters(in: range, with: replacementString)
  }
}
