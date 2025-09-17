//
//  NavigationBarConfiguration.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import SwiftUI

/// Configuration used inside the SwifUI environment for the navigation bar.
public struct NavigationBarConfiguration {
  // MARK: - Public Properties

  public let isHidden: Bool
  public let title: String?
  public let action: CloseAction?

  // MARK: - Init

  /// Creates a new `NavigationBarConfiguration`.
  /// - Parameters:
  ///   - isHidden: Flag indicating if the navigation bar is hidden.
  ///   - title: The title of the navigation bar
  ///   - action: Configuration for a custom button placed in the top right, as a close button.
  public init(isHidden: Bool = false, title: String?, action: CloseAction?) {
    self.isHidden = isHidden
    self.title = title
    self.action = action
  }
}

extension NavigationBarConfiguration {
  /// Type serving as a configuration for a custom close action on the navigation bar
  public struct CloseAction {
    public let icon: String
    public let action: () -> Void

    /// Creates a new `CloseAction`.
    /// - Parameters:
    ///   - icon: The icon on which the user will tap in order to close the screen.
    ///   - action: The action executed when the user taps on the icon.
    public init(icon: String, action: @escaping () -> Void) {
      self.icon = icon
      self.action = action
    }
  }
}

// MARK: - NavigationBarConfigurationModifier Definition

/// Special view modifier used to attach a navigaiton bar to a view.
public struct NavigationBarConfigurationModifier: ViewModifier {
  // MARK: - Private Properties

  private let config: NavigationBarConfiguration

  // MARK: - Init

  init(config: NavigationBarConfiguration) {
    self.config = config
  }

  // MARK: - Body

  public func body(content: Content) -> some View {
    content
      .toolbar(config.isHidden ? .hidden : .visible, for: .navigationBar)
      .navigationBarBackButtonHidden(config.action == nil)
      .if(config.action != nil) { content in
        content
          .navigationBarBackButtonHidden(true)
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              if let action = config.action {
                Button(action: action.action) {
                  Image(systemName: action.icon)
                }
              }
            }
          }
      }
      .if(config.title != nil) { content in
        content
          .navigationTitle(config.title ?? String())
      }
  }
}

extension View {
  /// Adds a custom navigation bar to this view.
  /// - Parameter configuration: Configuration of the navgation bar
  /// - Returns: View with an attached navigation bar.
  public func navigationBar(
    _ configuration: NavigationBarConfiguration
  ) -> ModifiedContent<Self, NavigationBarConfigurationModifier> {
    modifier(NavigationBarConfigurationModifier(config: configuration))
  }
}
