//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit

class TodayFullBackgroundCell: BaseTodayCell {

  // MARK: Public

  var topConstraint: NSLayoutConstraint!

  // MARK: - Private

  private lazy var backgroundImageView: UIImageView = {
    return ImageViewBuilder()
      .setCornerRadius(self.backgroundView?.layer.cornerRadius ?? 0)
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
      .setLeadingAnchor(leadingAnchor, padding: thumbnailPaddingTop)
      .setBottomAnchor(bottomAnchor, padding: thumbnailPaddingTop)
      .setTrailingAnchor(trailingAnchor, padding: thumbnailPaddingTop)

    topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: thumbnailPaddingTop)
    topConstraint.isActive = true
  }

  override func reset() {
    super.reset()
    backgroundImageView.image = nil
    titleLabel.text = nil
    categoryLabel.text = nil
    descriptionLabel.text = nil
  }
}

extension TodayFullBackgroundCell: TodayItemViewModelBindable {
  func bind(to viewModel: TodayItemViewModeling) {

    viewModel.outputs.category
      .asDriverJustComplete()
      .drive(categoryLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.title
      .asDriverJustComplete()
      .drive(titleLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.description
      .asDriverJustComplete()
      .drive(descriptionLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.backgroundImageURL
      .asDriverJustComplete()
      .drive(backgroundImageView.rx.loadImage)
      .disposed(by: disposeBag)

  }
}

extension TodayFullBackgroundCell: FullScreenLayoutCellAnimatedable {

  var thumbnailHeight: CGFloat {
    return 466
  }

  var fullScreenHeight: CGFloat {
    return 500
  }

  var thumbnailPaddingTop: CGFloat {
    return 24
  }

  var fullScreenPaddingTop: CGFloat {
    return 48
  }

}

extension TodayFullBackgroundCell: CellContentClassIdentifiable {
}
