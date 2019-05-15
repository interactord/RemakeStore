//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit

class AppRowCell: BaseCollectionViewCell {

  lazy var imageView: UIImageView = {
    return ImageViewBuilder()
      .setClipToBounds(true)
      .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
      .setCornerRadius(8)
      .setHeightAnchor(64)
      .setWidthAnchor(64)
      .build()
  }()

  lazy var nameLabel: UILabel = {
    return LabelBuilder()
      .setText("APP NAME")
      .setFont(DefaultTheme.Font.title3)
      .build()
  }()

  lazy var companyLabel: UILabel = {
    return LabelBuilder()
      .setText("COMPANY NAME")
      .setFont(DefaultTheme.Font.footnote)
      .build()
  }()

  lazy var getButton: UIButton = {
    return ButtonBuilder()
      .setTitle("GET")
      .setFont(DefaultTheme.Font.body)
      .setBackgroundColor(DefaultTheme.Color.lightGrayColor)
      .setCornerRadius(16)
      .setWidthAnchor(80)
      .setHeightAnchor(32)
      .build()
  }()

  lazy var stackView: UIStackView = {

    /// ------------
    /// [nameLabel]
    ///     | 4
    /// [companyLabel]
    /// ------------

    let horizonStackView = StackViewBuilder(
      arrangedSubViews: [
        nameLabel,
        companyLabel
      ])
      .setAxis(.vertical)
      .setSpacing(4)
      .build()

    /// ------------
    ///                   | [nameLabel]    |
    /// [imageView] - 4 - |      | 4       | - 4 - [getButton]
    ///                   | [companyLabel] |
    /// ------------

    return StackViewBuilder(
      arrangedSubViews: [
        imageView,
        horizonStackView,
        getButton
      ])
      .setSpacing(4)
      .setAlignment(.center)
      .build()
  }()

  override func setupSubView() {
    super.setupSubView()
    addSubview(stackView)
  }

  override func setupConstant() {
    super.setupConstant()
    stackView.fillSuperView()
  }

  override func reset() {
    super.reset()
    imageView.image = nil
    nameLabel.text = nil
    companyLabel.text = nil
  }
}

extension AppRowCell: FeedResultViewModelBindable {
  func bind(to viewModel: FeedResultViewModeling) {
    viewModel.outputs.name
      .asDriverJustComplete()
      .drive(imageView.rx.loadImage)
      .disposed(by: disposeBag)

    viewModel.outputs.companyName
      .asDriverJustComplete()
      .drive(companyLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.iconImageUrlPath
      .asDriverJustComplete()
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

extension AppRowCell: CellContentClassIdentifiable {
}
