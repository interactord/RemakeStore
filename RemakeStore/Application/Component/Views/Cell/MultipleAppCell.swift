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

  private(set) lazy var iconImageView: UIImageView = {
    return ImageViewBuilder()
      .setCornerRadius(8)
      .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
      .setClipToBounds(true)
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

  override func reset() {
    super.reset()
    iconImageView.image = nil
    nameLabel.text = nil
    companyLabel.text = nil
  }

}

extension MultipleAppCell: FeedResultViewModelBindable {
  func bind(to viewModel: FeedResultViewModeling) {

    iconImageView.moa.onSuccess = { img in
      let image = img as UIImage
      viewModel.inputs.fetchAppIconImage.onNext(image)
      return img
    }

    viewModel.outputs.name
      .asDriverJustComplete()
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.companyName
      .asDriverJustComplete()
      .drive(companyLabel.rx.text)
      .disposed(by: disposeBag)

    if nil == iconImageView.image {
      viewModel.outputs.iconImageUrlPath
        .asDriverJustComplete()
        .drive(iconImageView.rx.loadImage)
        .disposed(by: disposeBag)
    } else {
      viewModel.outputs.iconImage
        .asDriverJustComplete()
        .drive(iconImageView.rx.image)
        .disposed(by: disposeBag)
    }
  }
}

extension MultipleAppCell: CellContentClassIdentifiable {
}
