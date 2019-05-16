//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import SCUIBuildKit
import SCLayoutKit

class BaseTodayCell: BaseCollectionViewCell {

  private let scaleRatio: CGFloat = 0.9

  private lazy var replacedBackgroundView: UIView? = {
    return ViewBuilder()
      .setBackgroundColor(.white)
      .setCornerRadius(16)
      .setShadowOpacity(0.1)
      .setShadowOffset(.init(width: 0, height: 10))
      .setShadowRadius(10)
      .setShouldRasterize(true)
      .build()
  }()

  override var isHighlighted: Bool {
    didSet {

      var transform: CGAffineTransform = .identity

      if isHighlighted {
        transform = .init(scaleX: scaleRatio, y: scaleRatio)
      }

      animated(transform: transform)
    }
  }

  override func setupSubView() {
    super.setupSubView()

    self.backgroundView = replacedBackgroundView
    if let backgroundView = self.backgroundView {
      addSubview(backgroundView)
    }
    self.backgroundView?.fillSuperView()
  }
}
