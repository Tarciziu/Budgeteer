//
//  BTHostingController.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 14.09.2025.
//

import UIKit
import SwiftUI

/// Type serving as a wrapper for the SwiftUI screens in the navigation mechanism.
public class BTHostingController: UIViewController {
  // MARK: - Private Properties

  private let theme = AppearanceManager.sharedInstance.theme
  private let hostingController: UIHostingController<AnyView>
  private let config: Config

  // MARK: - Init

  /// Creates a new `BTHostingController`.
  /// - Parameters:
  ///   - containedView: The SwiftUI view contained inside.
  ///   - config: Configuration for the screen.
  public init(
    containedView: some View,
    config: Config = Config()
  ) {
    let hostingView = AnyView(
      containedView
        .environment(theme)
    )
    hostingController = UIHostingController(rootView: hostingView)
    self.config = config
    super.init(nibName: nil, bundle: nil)

    addChild(hostingController)
    view.addSubviewFilled(subView: hostingController.view)
    hostingController.didMove(toParent: self)
    hostingController.sizingOptions = [.intrinsicContentSize]
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UIViewController Methods

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if config.isNavigationBarHidden {
      navigationController?.setNavigationBarHidden(true, animated: false)
    }
  }

  public override var navigationItem: UINavigationItem {
    hostingController.navigationItem
  }

  public override var tabBarItem: UITabBarItem? {
    get { hostingController.tabBarItem }
    set { hostingController.tabBarItem = newValue }
  }
}

public extension BTHostingController {
  struct Config {
    let isNavigationBarHidden: Bool
    let isSwipeToPopAllowed: Bool

    public init(
      isNavigationBarHidden: Bool = false,
      isSwipeToPopAllowed: Bool = true
    ) {
      self.isNavigationBarHidden = isNavigationBarHidden
      self.isSwipeToPopAllowed = isSwipeToPopAllowed
    }
  }
}
