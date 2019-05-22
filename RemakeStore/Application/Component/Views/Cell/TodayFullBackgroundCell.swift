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

  private(set) lazy var backgroundImageView: UIImageView = {
    return ImageViewBuilder()
      .setCornerRadius(self.backgroundView?.layer.cornerRadius ?? 0)
      .setContentMode(.scaleAspectFill)
      .setClipToBounds(true)
      .build()
  }()

  private(set) lazy var descriptionLabel: UILabel = {
    return LabelBuilder()
      .setText("All the tools and apps your need to intelligently organize your life the right way.")
      .setFont(DefaultTheme.Font.callout)
      .setNumberOfLines(3)
      .build()
  }()

  private(set) lazy var stackView: UIStackView = {
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
      .setLeadingAnchor(leadingAnchor, padding: 24)
      .setBottomAnchor(bottomAnchor, padding: 24)
      .setTrailingAnchor(trailingAnchor, padding: 24)

    topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
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

    backgroundImageView.moa.onSuccess = { img in
      let image = img as UIImage
      viewModel.inputs.fetchImage.onNext(image)
      return img
    }

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

    if nil == backgroundImageView.image {
      viewModel.outputs.backgroundImageURL
        .asDriverJustComplete()
        .drive(backgroundImageView.rx.loadImage)
        .disposed(by: disposeBag)
    } else {
      viewModel.outputs.backgroundImage
        .asDriverJustComplete()
        .drive(backgroundImageView.rx.image)
        .disposed(by: disposeBag)
    }

  }
}

extension TodayFullBackgroundCell: BaseFullScreenLayoutAnimatedable {

  var thumbnailHeight: CGFloat {
    return 466
  }

  var fullScreenHeight: CGFloat {
    return 500
  }

}

extension TodayFullBackgroundCell: CellContentClassIdentifiable {
}
