//
// Created by Scott Moon on 2019-05-08.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit

protocol SearchResultCellType {
  var appIconImageView: UIImageView { get }
  var nameLabel: UILabel { get }
  var categoryLabel: UILabel { get }
  var ratingsLabel: UILabel { get }
  var getButton: UIButton { get }
  var screenShots: [UIImageView] { get }
}

class SearchResultCell: BaseCollectionViewCell {

  private lazy var infoTopStackView: UIStackView = {
    let verticalStackView = StackViewBuilder(arrangedSubViews: [
      nameLabel,
      categoryLabel,
      ratingsLabel
    ])
      .setAxis(.vertical)
      .build()

    return StackViewBuilder(arrangedSubViews: [
      appIconImageView,
      verticalStackView,
      getButton
    ])
      .setSpacing(12)
      .setAlignment(.center)
      .build()
  }()

  private lazy var overallStackView: UIStackView = {

    let screenshotsStackView = StackViewBuilder(arrangedSubViews: screenShots)
      .setSpacing(12)
      .setDistribution(.fillEqually)
      .build()

    return StackViewBuilder(arrangedSubViews: [
      infoTopStackView,
      screenshotsStackView
    ])
      .setSpacing(16)
      .setAxis(.vertical)
      .build()
  }()

  override func setupSubView() {
    super.setupSubView()

    addSubview(overallStackView)
    overallStackView.fillSuperView(padding: .init(top: 16, left: 16, bottom: 16, right: 16))

  }

}

extension SearchResultCell: SearchResultCellType {
  // MARK: - Private

  var appIconImageView: UIImageView {
    return ImageViewBuilder()
      .setBackgroundColor(.red)
      .setWidthAnchor(64)
      .setHeightAnchor(64)
      .setCornerRadius(12)
      .setClipToBounds(true)
      .build()
  }

  var nameLabel: UILabel {
    return LabelBuilder()
      .setText("APP NAME")
      .build()
  }

  var categoryLabel: UILabel {
    return LabelBuilder()
      .setText("Photo & Video")
      .build()
  }

  var ratingsLabel: UILabel {
    return LabelBuilder()
      .setText("611k")
      .build()
  }

  var getButton: UIButton {
    return ButtonBuilder()
      .setTitle("GET")
      .setFont(DefaultTheme.Font.body)
      .setWidthAnchor(80)
      .setHeightAnchor(32)
      .setBackgroundColor(#colorLiteral(red: 0.9601849914, green: 0.9601849914, blue: 0.9601849914, alpha: 1))
      .setCornerRadius(16)
      .build()
  }

  var screenShots: [UIImageView] {
    var views = [UIImageView]()

    for _ in 1...3 {
      let imageView = ImageViewBuilder()
        .setBackgroundColor(.blue)
        .setContentMode(.scaleAspectFill)
        .setCornerRadius(8)
        .setClipToBounds(true)
        .setBorderWidth(0.6)
        .setBorderColor(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1))
        .build()
      views.append(imageView)
    }

    return views
  }
}

extension SearchResultCell: CellContentClassIdentifiable {
}
