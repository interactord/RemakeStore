//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class TodayDetailController: BaseController {

  // MARK: Public
  var viewModel: TodayDetailViewModel!
  var todayItemViewModel: TodayItemViewModeling?
  var beginningAnimateConstraints: AnchoredConstraints?
  var finishedAnimatedConstraints: AnchoredConstraints?

  lazy var baseView: UIView = {
    guard let view = self.view else {
      return UIView()
    }
    return self.view
  }()

  lazy var dismissButton: UIButton = {
    return ButtonBuilder(type: .custom)
      .setImage(#imageLiteral(resourceName: "Close-button"))
      .setImage(#imageLiteral(resourceName: "Close-button").transformedAlpha(0.5), state: .highlighted)
      .setWidthAnchor(44)
      .setHeightAnchor(44)
      .build()
  }()

  // MARK: - Private

  private lazy var detailContentView = TodayDetailContentsView()

  override func setupViews() {
    super.setupViews()
    view.clipsToBounds = true
    view.addSubview(detailContentView)
    view.addSubview(dismissButton)
  }

  override func setupConstraints() {
    super.setupConstraints()
    detailContentView.fillSuperView()
    dismissButton
      .setTopAnchor(view.topAnchor, padding: 25)
      .setTrailingAnchor(view.trailingAnchor, padding: 25)
  }
}

extension TodayDetailController: BaseFullScreenAnimatable {
  func setupFullScreenLayout(startingFrame: CGRect) {
    self.beginningAnimateConstraints = baseView.anchor(
      top: view.superview?.topAnchor,
      leading: view.superview?.leadingAnchor,
      bottom: nil,
      trailing: nil,
      padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0),
      size: startingFrame.size
    )
    self.baseView.layoutIfNeeded()
  }

  func startFullScreenAnimation() {

    guard let superView = self.view.superview else {
      return
    }

    self.view.layer.cornerRadius = 16
    view?.defaultAnimated(
      animations: {
        self.beginningAnimateConstraints?.top?.constant = 0
        self.beginningAnimateConstraints?.leading?.constant = 0
        self.beginningAnimateConstraints?.width?.constant = superView.frame.width
        self.beginningAnimateConstraints?.height?.constant = superView.frame.height
        self.view.layoutIfNeeded()
      })
  }
}

extension TodayDetailController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    print("TodayDetailController")
  }
}
