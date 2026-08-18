//
//  ImageCatalog.swift
//  CoreUI
//
//  Created by Tarciziu Gologan on 20.09.2025.
//

import Foundation

/// Type containing image assets used all over the application.
public struct ImageCatalog {
  // MARK: - Public Properties

  public let uiAction: UIActions
  public let uiActionCircle: UIActionsCircle
  public let feedback: Feedback
  public let selection: Selection

  // MARK: - Initializer

  public init(
    uiAction: UIActions,
    uiActionCircle: UIActionsCircle,
    feedback: Feedback,
    selection: Selection
  ) {
    self.uiAction = uiAction
    self.uiActionCircle = uiActionCircle
    self.feedback = feedback
    self.selection = selection
  }
}

// MARK: - UI Actions definition

extension ImageCatalog {
  /// Type containing common UI action icons.
  public struct UIActions {
    public let chevronRight: String
    public let chevronLeft: String
    public let chevronUp: String
    public let chevronDown: String
    public let arrowRight: String
    public let arrowLeft: String
    public let arrowUp: String
    public let arrowDown: String
    public let download: String
    public let upload: String
    public let close: String
    public let plus: String
    public let minus: String
    public let check: String
    public let horizontalSlider: String

    public init(
      chevronRight: String,
      chevronLeft: String,
      chevronUp: String,
      chevronDown: String,
      arrowRight: String,
      arrowLeft: String,
      arrowUp: String,
      arrowDown: String,
      download: String,
      upload: String,
      close: String,
      plus: String,
      minus: String,
      check: String,
      horizontalSlider: String
    ) {
      self.chevronRight = chevronRight
      self.chevronLeft = chevronLeft
      self.chevronUp = chevronUp
      self.chevronDown = chevronDown
      self.arrowRight = arrowRight
      self.arrowLeft = arrowLeft
      self.arrowUp = arrowUp
      self.arrowDown = arrowDown
      self.download = download
      self.upload = upload
      self.close = close
      self.plus = plus
      self.minus = minus
      self.check = check
      self.horizontalSlider = horizontalSlider
    }
  }
}

// MARK: - UI Actions Circle definition

extension ImageCatalog {
  /// Type containing common UI action icons within a circle.
  public struct UIActionsCircle {
    public let closeCircle: String
    public let plusCircle: String
    public let minusCircle: String
    public let helpCircle: String
    public let infoCircle: String
    public let checkCircle: String

    public init(
      closeCircle: String,
      plusCircle: String,
      minusCircle: String,
      helpCircle: String,
      infoCircle: String,
      checkCircle: String
    ) {
      self.closeCircle = closeCircle
      self.plusCircle = plusCircle
      self.minusCircle = minusCircle
      self.helpCircle = helpCircle
      self.infoCircle = infoCircle
      self.checkCircle = checkCircle
    }
  }
}

// MARK: - Feedback Icons definition

extension ImageCatalog {
  /// Type containing feedback icons.
  public struct Feedback {
    public let warning: String
    public let error: String
    public let warningFilled: String
    public let errorFilled: String

    public init(
      warning: String,
      error: String,
      warningFilled: String,
      errorFilled: String
    ) {
      self.warning = warning
      self.error = error
      self.warningFilled = warningFilled
      self.errorFilled = errorFilled
    }
  }
}

// MARK: - Selection

extension ImageCatalog {
  /// Type containing selection icons.
  public struct Selection {
    public let circle: String
    public let circleFilled: String

    public init(circle: String, circleFilled: String) {
      self.circle = circle
      self.circleFilled = circleFilled
    }
  }
}
