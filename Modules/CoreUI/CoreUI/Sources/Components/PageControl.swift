//
//  PageControl.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 18/08/2026.
//

import SwiftUI

/// UI reusable component that displays a horizontal series of dots, each of which corresponds to a page in the app's document or other data-model entity.
public struct PageControl: UIViewRepresentable {
  // MARK: - Environment

  @Environment(BTTheme.self)
  private var theme

  // MARK: - Private Properties

  @Binding private var currentPage: Int
  private var pagesCount: Int

  // MARK: - Initializer

  /// Initializes a new ``PageControl``.
  /// - Parameters:
  ///   - currentPage: Binding for the current selected index.
  ///   - pagesCount: Amount of pages.
  public init(currentPage: Binding<Int>, pagesCount: Int) {
    self._currentPage = currentPage
    self.pagesCount = pagesCount
  }
}

// MARK: - UIViewRepresentable conformation

extension PageControl {
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  public func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = pagesCount
    control.currentPage = currentPage
    control.pageIndicatorTintColor = UIColor(theme.colorPalette.pageControl.unselected)
    control.currentPageIndicatorTintColor = UIColor(theme.colorPalette.pageControl.selected)

    control.addTarget(
      context.coordinator,
      action: #selector(Coordinator.pageControlValueChanged(_:)),
      for: .valueChanged
    )

    return control
  }

  public func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.currentPage = currentPage
  }

  public class Coordinator: NSObject {
    var parent: PageControl

    public init(_ parent: PageControl) {
      self.parent = parent
    }

    @objc func pageControlValueChanged(_ sender: UIPageControl) {
      parent.currentPage = sender.currentPage
    }
  }
}
