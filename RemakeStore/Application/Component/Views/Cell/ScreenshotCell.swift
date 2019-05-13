//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCLayoutKit
import SCUIBuildKit
import RxCocoa
import RxSwift

class ScreenshotCell: BaseCollectionViewCell {

  private lazy var screenshotImage: UIImageView = {
    let imgView = ImageViewBuilder()
      .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
      .setCornerRadius(12)
      .setContentMode(.scaleAspectFill)
      .build()

    addSubview(imgView)
    return imgView
  }()

  override func setupConstant() {
    super.setupConstant()
    screenshotImage.fillSuperView()
  }

  override func reset() {
    super.reset()
    screenshotImage.image = nil
  }
}

extension ScreenshotCell: ScreenshotViewModelBindable {
  func bind(to viewModel: ScreenshotViewModeling) {

    viewModel.outputs.screenshot
      .bind(to: screenshotImage.rx.loadImage)
      .disposed(by: disposeBag)
  }
}

extension ScreenshotCell: CellContentClassIdentifiable {

}
