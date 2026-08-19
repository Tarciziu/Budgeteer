//
//  AppImages.swift
//  Budgeteer
//
//  Created by Tarciziu Gologan on 20.09.2025.
//

import BTCoreUI

extension ImageCatalog {
  static let appImageCatalog: ImageCatalog = {
    let uiActions = UIActions(
      chevronRight: "chevron.right",
      chevronLeft: "chevron.left",
      chevronUp: "chevron.up",
      chevronDown: "chevron.down",
      arrowRight: "arrow.right",
      arrowLeft: "arrow.left",
      arrowUp: "arrow.up",
      arrowDown: "arrow.down",
      download: "square.and.arrow.down",
      upload: "square.and.arrow.up",
      close: "xmark",
      plus: "plus",
      minus: "minus",
      check: "checkmark",
      horizontalSlider: "slider.horizontal.3"
    )

    let uiActionsCircle = UIActionsCircle(
      closeCircle: "xmark.circle",
      plusCircle: "plus.circle",
      minusCircle: "minus.circle",
      helpCircle: "questionmark.circle",
      infoCircle: "info.circle",
      checkCircle: "checkmark.circle"
    )

    let feedback = Feedback(
      warning: "exclamationmark.triangle",
      error: "exclamationmark.octagon",
      warningFilled: "exclamationmark.triangle.fill",
      errorFilled: "exclamationmark.octagon.fill"
    )

    let selection = Selection(
      circle: "circle",
      circleFilled: "circle.fill"
    )

    return ImageCatalog(
      uiAction: uiActions,
      uiActionCircle: uiActionsCircle,
      feedback: feedback,
      selection: selection
    )
  }()
}
