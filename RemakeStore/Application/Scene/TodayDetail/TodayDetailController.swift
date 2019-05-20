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
    view.addSubview(detailContentView)
    view.addSubview(dismissButton)
  }

  override func setupConstraints() {
    super.setupConstraints()
    detailContentView.fillSuperView()
    dismissButton
      .setTopAnchor(view.topAnchor, padding: 30)
      .setLeadingAnchor(view.leadingAnchor, padding: 30)
  }

}

extension TodayDetailController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    print("TodayDetailController")
  }
}
