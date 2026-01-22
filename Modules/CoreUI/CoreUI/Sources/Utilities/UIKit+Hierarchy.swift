//
//  UIKit+Hierarchy.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 06.01.2026.
//

import UIKit

/// Extension to `UIApplication` to retrieve the top most view controller.
public extension UIApplication {
  /// Gets the top most view controller in the app's key window.
  /// - Returns: The top most `UIViewController` if available, otherwise `nil`.
  func topMostViewController() -> UIViewController? {
    (UIApplication.shared.connectedScenes.first { $0 is UIWindowScene } as? UIWindowScene)?
      .windows
      .first(where: \.isKeyWindow)?
      .topMostViewController()
  }
}

/// Extension to `UIWindow` to retrieve the top most view controller.
public extension UIWindow {
  /// Gets the top most view controller starting from the window's root view controller.
  /// - Returns: The top most `UIViewController` if available, otherwise `nil`.
  func topMostViewController() -> UIViewController? {
    guard let rootViewController else { return nil }
    return rootViewController.topMostViewController()
  }
}

/// Extension to `UIViewController` to retrieve the top most view controller.
public extension UIViewController {
  /// Gets the top most view controller starting from the current view controller.
  /// - Returns: The top most `UIViewController`.
  func topMostViewController() -> UIViewController {
    if
      let currentlyPresentedViewController = self.presentedViewController,
      !currentlyPresentedViewController.isBeingDismissed,
      !currentlyPresentedViewController.isMovingFromParent {
      return currentlyPresentedViewController.topMostViewController()
    }

    if
      let currentlyNavigationController = self as? UINavigationController,
      let currentlyVisibleViewController = currentlyNavigationController.visibleViewController {
      return currentlyVisibleViewController.topMostViewController()
    }

    if
      let currentTabController = self as? UITabBarController,
      let currentSelectedController = currentTabController.selectedViewController {
      return currentSelectedController.topMostViewController()
    }
    return self
  }
}
