//
//  NumericalVisualTransformation.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 25.12.2025.
//

import Foundation

/// An entity responsible to transform numerical inputs.
public class NumericalVisualTransformation: VisualTransformation {
  // MARK: - Private Properties

  private let formatter: NumberFormatter

  // MARK: - Initializer

  /// Initializes a new instance of ``NumericalVisualTransformation``.
  /// - Parameter formatter: The formatter used for text formatting..
  public init(formatter: NumberFormatter, ) {
    self.formatter = formatter
  }

  // MARK: - Visual Transformation conformance

  public func transform(_ text: String) -> (String, String) {
    /// Removing grouping separator to have the equivalent for the decimal number value with only the decimal separator
    var unformattedValue = text.replacingOccurrences(
      of: formatter.groupingSeparator,
      with: String()
    )

    /// We separate the components based on decimal separator, thus having only 0, 1 or 2 components.
    /// 0 in case we have an empty string, 1 if we have an integer, 2 if we have a decimal number.
    var unformattedValueComponents = unformattedValue.components(separatedBy: formatter.decimalSeparator)

    if unformattedValueComponents.count > 1 {
      /// In case we have more than the amount of decimals we are supposed to.
      if unformattedValueComponents[1].count > formatter.maximumFractionDigits {
        let digits = unformattedValueComponents[1].prefix(formatter.maximumFractionDigits)
        unformattedValueComponents = [unformattedValueComponents[0], String(digits)]
        /// We remove the last item in order to have the exact amount of `maximumFractionDigits` provided by the formatter.
        unformattedValue.removeLast()
      }
    }

    guard unformattedValueComponents[0].count <= formatter.maximumIntegerDigits else {
      let formattedValue = getLimitedNumber(
        digits: formatter.maximumIntegerDigits,
        unformattedValueComponents: unformattedValueComponents
      ) ?? unformattedValue
      return (formattedValue, unformattedValue)
    }
    let formattedValue = getLimitedNumber(unformattedValueComponents: unformattedValueComponents) ?? unformattedValue
    return (formattedValue, unformattedValue)
  }

  public func isValidForTransformation(_ text: String) -> Bool {
    let unformattedValue = text.replacingOccurrences(of: formatter.groupingSeparator, with: String())
    let unformattedValueComponents = unformattedValue.components(separatedBy: formatter.decimalSeparator)
    let digitsCount = unformattedValueComponents[0].count
    var decimalsCount = Int.zero
    if unformattedValueComponents.count > 1 {
      decimalsCount = unformattedValueComponents[1].count
    }

    if formatter.maximumFractionDigits == .zero {
      return !unformattedValue.contains(formatter.decimalSeparator)
      && digitsCount <= formatter.maximumIntegerDigits && decimalsCount <= formatter.maximumFractionDigits
    }
    return digitsCount <= formatter.maximumIntegerDigits && decimalsCount <= formatter.maximumFractionDigits
    && unformattedValueComponents.count <= 2
  }

  // MARK: - Private Methods

  private func getLimitedNumber(digits: Int = .max, unformattedValueComponents: [String]) -> String? {
    let numberString = unformattedValueComponents[0].prefix(digits)
    let number = Decimal(string: String(numberString), locale: formatter.locale)

    if
      unformattedValueComponents[0].isEmpty,
      var result = formatter.string(from: .zero as NSDecimalNumber),
      unformattedValueComponents.count > 1 {
      result += formatter.decimalSeparator + unformattedValueComponents[1].prefix(formatter.maximumFractionDigits)
      return result
    }

    if
      let number,
      var result = formatter.string(from: number as NSDecimalNumber) {
      if unformattedValueComponents.count > 1 {
        result += formatter.decimalSeparator + unformattedValueComponents[1].prefix(formatter.maximumFractionDigits)
      }
      return result
    }
    return nil
  }
}
