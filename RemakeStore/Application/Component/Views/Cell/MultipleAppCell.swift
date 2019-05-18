//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class MultipleAppCell: BaseCollectionViewCell {

  private lazy var nameLabel: UILabel = {
    return LabelBuilder()
      .setText("APP NAME")
      .setFont(DefaultTheme.Font.title3)
      .build()
  }()

  private lazy var companyLabel: UILabel = {
    return LabelBuilder()
      .setText("COMMPANY NAME")
      .setFont(DefaultTheme.Font.footnote)
      .build()
  }()

  private lazy var iconImageView: UIImageView = {
    return ImageViewBuilder()
      .setCornerRadius(8)
      .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
      .setContentMode(.scaleAspectFill)
      .setWidthAnchor(64)
      .setHeightAnchor(64)
      .build()
  }()

  private lazy var getButton: UIButton = {
    return ButtonBuilder()
      .setTitle("GET")
      .setBackgroundColor(DefaultTheme.Color.lightGrayColor)
      .setCornerRadius(16)
      .setWidthAnchor(80)
      .setHeightAnchor(32)
      .build()
  }()

  private lazy var separateStackView: UIStackView = {
    let lineView = ViewBuilder()
      .setBackgroundColor(DefaultTheme.Color.lightGrayColor)
      .setHeightAnchor(1)
      .build()

    let spacingView = ViewBuilder()
      .setWidthAnchor(64)
      .build()

    return StackViewBuilder(
      arrangedSubViews: [
        spacingView,
        lineView
      ])
      .setSpacing(16)
      .build()
  }()

  private lazy var stackView: UIStackView = {
    /// nameLabel + compnayLabel
    let textVerticalGroup = StackViewBuilder(
      arrangedSubViews: [
        nameLabel,
        companyLabel
      ])
      .setAxis(.vertical)
      .setSpacing(4)
      .build()

    /// iconImageView + textVerticalGroup + getButton
    let contentGroup = StackViewBuilder(
      arrangedSubViews: [
        iconImageView,
        textVerticalGroup,
        getButton
      ])
      .setAlignment(.center)
      .setSpacing(16)
      .build()

    /// contentGroup + separateView
    let finalStackView = StackViewBuilder(
      arrangedSubViews: [
        contentGroup,
        separateStackView
      ])
      .setAxis(.vertical)
      .setSpacing(8)
      .build()

    addSubview(finalStackView)

    return finalStackView
  }()

  override func setupConstant() {
    super.setupConstant()
    stackView.fillSuperView()
  }

}

extension MultipleAppCell: CellContentClassIdentifiable {
}
