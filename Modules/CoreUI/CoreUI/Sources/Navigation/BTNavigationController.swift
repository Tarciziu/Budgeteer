//
//  BTNavigationController.swift
//  Core
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import UIKit

/// Type serving as the main container used for navigation in the app.
///
/// - Note: This type should be subclassed by the coordinators, not used alone.
public class BTNavigationController: UINavigationController {
  // MARK: - Init

  public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UINavigationController Methods

  override open func viewDidLoad() {
    super.viewDidLoad()
    configureInteractivePopGestureRecognizer()
  }

  // MARK: - Private Methods

  private func configureInteractivePopGestureRecognizer() {
    interactivePopGestureRecognizer?.isEnabled = true
    interactivePopGestureRecognizer?.delegate = self
  }
}

extension BTNavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    true
  }

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard gestureRecognizer == interactivePopGestureRecognizer else {
      return true
    }
    // Avoding the swipe to pop on the root view controller itself.
    return viewControllers.count > 1
  }
}
