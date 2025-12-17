//
//  RegularButton.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 29.10.2025.
//

import SwiftUI
import BTCore

public typealias ButtonProgressViewBuilder = () -> any View

/// A standard button component with customizable styles and loading state.
public struct RegularButton: View {
  // MARK: - Nested Types

  public enum ButtonType: Equatable {
    case primary
    case secondary
  }

  // MARK: - Environment Properties

  @Environment(BTTheme.self)
  private var theme: BTTheme
  @Environment(\.isLoading)
  private var isLoading

  // MARK: - Private Properties

  private let type: ButtonType
  private let text: any StringProtocol
  private let imageName: String?
  private let action: Action
  private let progressViewBuilder: ButtonProgressViewBuilder?

  private var buttonStyle: RegularButtonContentStyle {
    return RegularButtonContentStyle(
      type: type,
      text: text,
      imageName: imageName,
      progressView: progressViewBuilder
    )
  }

  // MARK: - Initializer

  /// Initializes a `RegularButton` with an icon in a given style.
  /// - Parameters:
  ///   - type: The type of the button.
  ///   - text: The text to display on the button.
  ///   - imageName: The name of the image resource to display.
  ///   - action: The action to perform when the user triggers the button.
  ///   - progressViewBuilder: The custom view to display in the loading state.
  public init(
    type: ButtonType = .primary,
    text: String = String(),
    imageName: String?,
    action: @escaping Action,
    progressViewBuilder: ButtonProgressViewBuilder? = nil
  ) {
    self.type = type
    self.text = text
    self.imageName = imageName
    self.action = action
    self.progressViewBuilder = progressViewBuilder
  }

  // MARK: - Body

  public var body: some View {
    contentView
  }

  // MARK: - Subviews

  @ViewBuilder private var contentView: some View {
    Button(String()) {
      if !isLoading {
        action()
      }
    }
    .buttonStyle(buttonStyle)
  }
}
