//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SCLayoutKit
import SCUIBuildKit

class AppsHeaderCell: BaseCollectionViewCell {

  private lazy var titleLabel: UILabel = {
    return LabelBuilder()
      .setText("KEEPING UP WITH FRIENDS IS FASTER THEN EVER")
      .setFont(DefaultTheme.Font.title2)
      .build()
  }()

  private lazy var companyLabel: UILabel = {
    return LabelBuilder()
      .setText("THE APP")
      .setFont(DefaultTheme.Font.caption1)
      .setNumberOfLines(2)
      .setTextColor(DefaultTheme.Color.primaryColor)
      .build()
  }()

  private lazy var backgroundImageView: UIImageView = {
    return ImageViewBuilder()
      .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
      .setContentMode(.scaleAspectFill)
      .setCornerRadius(8)
      .build()
  }()

  private lazy var stackView: UIStackView = {
    return StackViewBuilder(
      arrangedSubViews: [
        companyLabel,
        titleLabel,
        backgroundImageView
      ])
      .setAxis(.vertical)
      .setSpacing(12)
      .build()
  }()

  override func setupSubView() {
    super.setupSubView()
    addSubview(stackView)
  }

  override func setupConstant() {
    super.setupConstant()
    stackView.fillSuperView(padding: .init(top: 10, left: 0, bottom: 0, right: 0))
  }

  override func reset() {
    super.reset()
    titleLabel.text = ""
    companyLabel.text = ""
    backgroundImageView.image = nil
  }
}

extension AppsHeaderCell: SocialAppViewModelBindable {
  func bind(to viewModel: SocialAppViewModeling) {
    viewModel.outputs.name
      .asDriverJustComplete()
      .drive(companyLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.tagLine
      .asDriverJustComplete()
      .drive(titleLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.imageUrlPath
      .asDriverJustComplete()
      .drive(backgroundImageView.rx.loadImage)
      .disposed(by: disposeBag)
  }
}

extension AppsHeaderCell: CellContentClassIdentifiable {
}
