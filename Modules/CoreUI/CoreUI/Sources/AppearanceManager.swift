//
//  AppearanceManager.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import Foundation

/// Type used by all entities of the app which require the app theme.
///
/// - Note:  This theme should be configured from the main module. We use this point only as an easy access to other entities
/// which require the theme, such as hosting controllers.
public final class AppearanceManager {
  // MARK: - Public Properties

  private var _theme: BTTheme?

  // MARK: - Private Properties

  public var theme: BTTheme {
    guard let unwrappedTheme = _theme else {
      fatalError("The theme was accessed before it was initialised.")
    }
    return unwrappedTheme
  }

  // MARK: - Shared Instance

  public static let sharedInstance = AppearanceManager()

  // MARK: - Public Methods

  public func setTheme(_ theme: BTTheme) {
    self._theme = theme
  }

  // MARK: - Init

  private init() {}
}
