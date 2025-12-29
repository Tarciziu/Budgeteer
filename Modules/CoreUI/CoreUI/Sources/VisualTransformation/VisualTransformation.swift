//
//  VisualTransformation.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 25.12.2025.
//

import Foundation

/// A protocol defining a visual transformation for changing visual output of the ``InputField``.
public protocol VisualTransformation {
  /// Transforms the given text and returns a tuple containing the transformed and original text.
  /// - Parameter text: The text to be transformed.
  /// - Returns: A tuple where the first element is the transformed (formatted) text and the second element is the original (unformatted) text.
  func transform(_ text: String) -> (String, String)
  /// Checks if the given text is valid for transformation.
  /// - Parameter text: The text to be validated.
  /// - Returns: A boolean indicating whether the text is valid for transformation.
  func isValidForTransformation(_ text: String) -> Bool
}

extension VisualTransformation {
  public func isValidForTransformation(_ text: String) -> Bool {
    true
  }
}
