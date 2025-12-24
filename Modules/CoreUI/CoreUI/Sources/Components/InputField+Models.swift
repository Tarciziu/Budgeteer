//
//  InputField+Models.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 22.11.2025.
//

import SwiftUI
import BTCore

extension InputField {
  /// Enumeration representing the different states of an ``InputField``.
  public enum InputFieldState {
    /// The normal state of the input field.
    case normal
    /// The disabled state of the input field.
    case disabled
    /// The error state of the input field.
    case error
  }

  /// Model representing the configuration of an icon to be displayed on the ``InputField``.
  public struct IconConfig {
    let name: String
    let isEnabled: Bool?
    let action: Action?

    /// Initializes a new ``InputField.IconConfig``.
    /// - Parameters:
    ///   - name: String representing the name of the system icon.
    ///   - isEnabled: Boolean representing the state of the icon.
    ///   - action: Action to be executed on icon press.
    public init(name: String, isEnabled: Bool? = nil, action: Action?) {
      self.name = name
      self.isEnabled = isEnabled
      self.action = action
    }
  }
}
