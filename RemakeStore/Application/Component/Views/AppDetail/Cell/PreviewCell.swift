//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit
import RxSwift
import RxCocoa

class PreviewCell: BaseCollectionViewCell {

  // MARK: - Views

  lazy var previewLabel: UILabel = {
    return LabelBuilder()
      .setText("Preview")
      .setFont(DefaultTheme.Font.title3)
      .build()
  }()

  lazy var previewScreenshotsView = PreviewScreenshotsView(
		withLayoutStyle: .horizontalSnapping
	)

  override func setupSubView() {
    super.setupSubView()
    addSubview(previewLabel)
    addSubview(previewScreenshotsView)
  }

  override func setupConstant() {
    super.setupConstant()

    previewLabel
      .setTopAnchor(topAnchor)
      .setLeadingAnchor(leadingAnchor, padding: 20)
      .setTrailingAnchor(trailingAnchor, padding: 20)

    previewScreenshotsView
      .setTopAnchor(previewLabel.bottomAnchor, padding: 20)
      .setLeadingAnchor(leadingAnchor)
      .setBottomAnchor(bottomAnchor)
      .setTrailingAnchor(trailingAnchor)
  }

  func bind(to viewModels: [ScreenshotViewModeling]) {
    Observable.just(viewModels)
      .bind(to: previewScreenshotsView.rx.updateViewModels)
      .disposed(by: disposeBag)
  }

}

extension PreviewCell: CellContentClassIdentifiable {
}
