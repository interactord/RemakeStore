//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class TodayHeader: BaseCollectionReusableView {

  private lazy var dateLebel: UILabel = {
    return LabelBuilder()
      .setText("THURSDAY, APRIL 5")
      .setFont(DefaultTheme.Font.subhead)
      .build()
  }()

  private lazy var todayLabel: UILabel = {
    return LabelBuilder()
      .setText("Today")
      .setFont(DefaultTheme.Font.largeTitle)
      .build()
  }()

  private lazy var avatarImageView: UIImageView = {
    return ImageViewBuilder()
      .setImage(#imageLiteral(resourceName: "Avatar"))
      .setCornerRadius(21)
      .setClipToBounds(true)
      .setWidthAnchor(42)
      .setHeightAnchor(42)
      .build()
  }()

  private lazy var stackView: UIStackView = {
    let verticalStackView = StackViewBuilder(
      arrangedSubViews: [
        self.dateLebel,
        self.todayLabel
      ])
      .setAxis(.vertical)
      .build()

    return StackViewBuilder(
      arrangedSubViews: [
        verticalStackView,
        self.avatarImageView
      ])
      .setAlignment(.center)
      .build()
  }()

  override func setupSubView() {
    super.setupSubView()
    addSubview(stackView)
  }

  override func setupConstant() {
    super.setupConstant()
    stackView
      .setLeadingAnchor(leadingAnchor, padding: 32)
      .setBottomAnchor(bottomAnchor)
      .setTrailingAnchor(trailingAnchor, padding: 32)
  }

}

extension TodayHeader: CellContentClassIdentifiable {
}
