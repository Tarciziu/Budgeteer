//
//  UIVIew+Layout.swift
//  CoreUI
//
//  Created by Adrian-Zoltan Herczeg on 22.09.2025.
//

import UIKit

/// Collection of additional methods for UIKit dedicated to layouting.
extension UIView {
  /// Adds a suview to the current view and adjusts it's constraints to completly expand on the current view.
  /// - Parameter subview: The UIView to be added on the current view.
  public func addSubviewFilled(subView: UIView) {
    addSubview(subView)
    subView.translatesAutoresizingMaskIntoConstraints = false
    subView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    subView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    subView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    subView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
}
