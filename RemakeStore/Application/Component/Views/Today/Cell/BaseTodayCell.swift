//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import SCUIBuildKit
import SCLayoutKit

class BaseTodayCell: BaseCollectionViewCell {

  private var unabledTouchAnimation = true

  lazy var categoryLabel: UILabel = {
    return LabelBuilder()
      .setText("CATEGORY LABEL")
      .setFont(DefaultTheme.Font.title3)
      .build()
  }()

  lazy var titleLabel: UILabel = {
    return LabelBuilder()
      .setText("TITLE LABEL")
      .setFont(DefaultTheme.Font.title1)
      .build()
  }()

  // MARK: - Private

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
      if unabledTouchAnimation {
        var transform: CGAffineTransform = .identity
        if isHighlighted {
          transform = .init(scaleX: scaleRatio, y: scaleRatio)
        }
        UIView.animated(transform: transform) {
          self.transform = transform
        }
      }
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

  func clearBackgroundEffectView() {
    backgroundView = UIView()
    backgroundView?.backgroundColor = .white
    unabledTouchAnimation = false
  }
}
