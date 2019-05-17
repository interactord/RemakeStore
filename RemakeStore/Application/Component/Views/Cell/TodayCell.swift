//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit

class TodayCell: BaseTodayCell {

  // MARK: Public

  var topConstraint: NSLayoutConstraint!

  // MARK: - Private

  private lazy var backgroundImageView: UIImageView = {
    return ImageViewBuilder()
      .setImage(#imageLiteral(resourceName: "2019-05-18-cinema-bacground-v01"))
      .setContentMode(.scaleAspectFill)
      .setClipToBounds(true)
      .build()
  }()

  private lazy var descriptionLabel: UILabel = {
    return LabelBuilder()
      .setText("All the tools and apps your need to intelligently organize your life the right way.")
      .setFont(DefaultTheme.Font.callout)
      .setNumberOfLines(3)
      .build()
  }()

  private lazy var stackView: UIStackView = {
    return StackViewBuilder(
      arrangedSubViews: [
        categoryLabel,
        titleLabel,
        UIView(),
        descriptionLabel
      ])
      .setAxis(.vertical)
      .setSpacing(8)
      .build()
  }()

  override func setupSubView() {
    super.setupSubView()
    addSubview(backgroundImageView)
    addSubview(stackView)
  }

  override func setupConstant() {
    super.setupConstant()
    backgroundImageView.fillSuperView()
    stackView
      .setLeadingAnchor(leadingAnchor, padding: 24)
      .setBottomAnchor(bottomAnchor, padding: 24)
      .setTrailingAnchor(trailingAnchor, padding: 24)

    topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
    topConstraint.isActive = true
  }
}

extension TodayCell: CellContentClassIdentifiable {
}
