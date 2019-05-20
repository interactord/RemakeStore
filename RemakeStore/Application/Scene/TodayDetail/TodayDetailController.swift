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

  func viewWillAnimated() {
    self.view.layer.cornerRadius = 16
  }

}

extension TodayDetailController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    print("TodayDetailController")
  }
}
