//
//  LoadableContentView.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 01.10.2025.
//

import SwiftUI
import BTCore

/// A view that displays different content based on the state of a `LoadableContent`.
public struct LoadableContentView<Content, Failure>: View {
  // MARK: - Nested Types

  public typealias EmptyViewBuilder = () -> any View
  public typealias LoadingViewBuilder = (Content?) -> any View
  public typealias LoadedViewBuilder = (Content) -> any View
  public typealias FailureViewBuilder = (Failure?) -> any View

  // MARK: - Private Properties

  private let content: LoadableContent<Content, Failure>

  private var emptyView: EmptyViewBuilder
  private var loadingView: LoadingViewBuilder
  private var loadedView: LoadedViewBuilder
  private var failureView: FailureViewBuilder

  // MARK: - Initializer

  /// Initializes a `LoadableContentView` with the provided content and view builders for different states.
  /// - Parameters:
  ///   - content: The loadable content that determines which view to display.
  ///   - emptyView: A closure that returns the view to display when the content is empty.
  ///   - loadingView: A closure that returns the view to display when the content is loading. It receives an optional `Content` parameter.
  ///   - loadedView: A closure that returns the view to display when the content is successfully loaded. It receives a `Content` parameter.
  ///   - failureView: A closure that returns the view to display when there is a failure. It receives an optional `Failure` parameter.
  public init(
    content: LoadableContent<Content, Failure>,
    emptyView: @escaping EmptyViewBuilder,
    loadingView: @escaping LoadingViewBuilder,
    loadedView: @escaping LoadedViewBuilder,
    failureView: @escaping FailureViewBuilder
  ) {
    self.content = content
    self.emptyView = emptyView
    self.loadingView = loadingView
    self.loadedView = loadedView
    self.failureView = failureView
  }

  // MARK: - Body

  public var body: some View {
    switch content {
    case .empty:
      AnyView(emptyView())
    case .isLoading(let partialContent):
      AnyView(loadingView(partialContent))
    case .loaded(let loadedContent):
      AnyView(loadedView(loadedContent))
    case .failed(let error):
      AnyView(failureView(error))
    @unknown default:
      EmptyView()
    }
  }
}

extension LoadableContentView where Failure == Never {
  /// Initializes a `LoadableContentView` with the provided content and view builders for different states, excluding failure handling.
  /// - Parameters:
  ///   - content: The loadable content that determines which view to display.
  ///   - emptyView: A closure that returns the view to display when the content is empty.
  ///   - loadingView: A closure that returns the view to display when the content is loading. It receives an optional `Content` parameter.
  ///   - loadedView: A closure that returns the view to display when the content is successfully loaded. It receives a `Content` parameter.
  public init(
    content: LoadableContent<Content, Never>,
    emptyView: @escaping EmptyViewBuilder,
    loadingView: @escaping LoadingViewBuilder,
    loadedView: @escaping LoadedViewBuilder
  ) {
    self.content = content
    self.emptyView = emptyView
    self.loadingView = loadingView
    self.loadedView = loadedView
    self.failureView = { _ in EmptyView() }
  }
}
