//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCLayoutKit
import SCUIBuildKit

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
}

extension ScreenshotCell: CellContentClassIdentifiable {

}
