//
// Created by Scott Moon on 2019-05-08.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SCUIBuildKit
import SCLayoutKit
import SCReviewRatingKit
import moa

private protocol SearchResultCellMakeElement {
  func makeScreenShotImageView() -> UIImageView
}

class SearchResultCell: BaseCollectionViewCell {

  // MARK: - Views

  lazy var appIconImageView: UIImageView = {
    return ImageViewBuilder()
      .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
      .setWidthAnchor(64)
      .setHeightAnchor(64)
      .setCornerRadius(12)
      .setClipToBounds(true)
      .build()
  }()

  lazy var nameLabel: UILabel = {
    return LabelBuilder()
      .setText("APP NAME")
      .build()
  }()

  lazy var categoryLabel: UILabel = {
    return LabelBuilder()
      .setText("Photo & Video")
      .build()
  }()

  lazy var reviewCountLabel: UILabel = {
    return LabelBuilder()
      .setText("611k")
      .setFont(DefaultTheme.Font.callout)
      .build()
  }()

  lazy var ratingsView: SCReviewRatingView = {
    return RatingStarBuilder()
      .setValue(currentValue: 2, minimumValue: 0, maximumValue: 5)
      .setMode(allowHalfMode: true, accuratedHalfMode: true)
      .setColor(tintColor: .lightGray)
      .setBackgroundColor(.white)
      .setSpacing(2)
      .setHeigthAnchor(20)
      .setWidthAnchor(64)
      .build()
  }()

  lazy var getButton: UIButton = {
    return ButtonBuilder()
      .setTitle("GET")
      .setFont(DefaultTheme.Font.body)
      .setWidthAnchor(80)
      .setHeightAnchor(32)
      .setBackgroundColor(DefaultTheme.Color.secondaryColor)
      .setCornerRadius(16)
      .build()
  }()

  private lazy var infoTopStackView: UIStackView = {
    let ratingSteckView = StackViewBuilder(arrangedSubViews: [
      ratingsView,
      reviewCountLabel
    ]).build()

    let verticalStackView = StackViewBuilder(arrangedSubViews: [
      nameLabel,
      categoryLabel,
      ratingSteckView
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

  lazy var screenshortsStackView: UIStackView = {
    return StackViewBuilder(arrangedSubViews: [])
      .setSpacing(12)
      .setDistribution(.fillEqually)
      .setAlignment(.center)
      .build()
  }()

  override func setupSubView() {
    super.setupSubView()

    addSubview(infoTopStackView)
    addSubview(screenshortsStackView)
  }

  override func setupConstant() {
    super.setupConstant()

    infoTopStackView
      .setTopAnchor(topAnchor, padding: 16)
      .setLeadingAnchor(leadingAnchor, padding: 16)
      .setBottomAnchor(screenshortsStackView.topAnchor, padding: 16)
      .setTrailingAnchor(trailingAnchor, padding: 16)

    screenshortsStackView
      .setTopAnchor(infoTopStackView.bottomAnchor, padding: 16)
      .setBottomAnchor(bottomAnchor, padding: 16)

    let maxWidth = UIScreen.main.bounds.width - 32
    screenshortsStackView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
    screenshortsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  }

  override func reset() {
    super.reset()
    appIconImageView.image = nil
    nameLabel.text = ""
    categoryLabel.text = ""
    reviewCountLabel.text = ""
    ratingsView.currentValue = 0
    _ = screenshortsStackView.removeAllArrangedSubviews()
  }
}

extension SearchResultCell: LookupViewModelBindable {

  // MARK: - functions for protocol

  func bind(to viewModel: LookupViewModeling) {

    viewModel.outputs.name
      .asDriverJustComplete()
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.category
      .asDriverJustComplete()
      .drive(categoryLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.rating
      .asDriverJustComplete()
      .drive(ratingsView.rx.currentValue)
      .disposed(by: disposeBag)

    viewModel.outputs.reviewCount
      .asDriverJustComplete()
      .drive(reviewCountLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.appIconImageUrlPath
      .asDriverJustComplete()
      .drive(appIconImageView.rx.loadImage)
      .disposed(by: disposeBag)

    viewModel.outputs.screenshotUrlPaths
      .asDriverJustComplete()
      .drive(rx.updateScreenshots)
      .disposed(by: disposeBag)
  }
}

extension SearchResultCell: SearchResultCellMakeElement {
  func makeScreenShotImageView() -> UIImageView {
    return ImageViewBuilder()
      .setContentMode(.scaleAspectFill)
      .setCornerRadius(8)
      .setWidthAnchor(80)
      .setClipToBounds(true)
      .setBorderWidth(0.6)
      .setBorderColor(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1))
      .build()
  }
}

// MARK: - RX Binder

extension Reactive where Base: SearchResultCell {
  internal var updateScreenshots: Binder<[String]> {
    return Binder(self.base) { base, result in
      let minCount = min(3, result.count)
      let screenshots = (1...minCount).map { _ in base.makeScreenShotImageView() }
      _ = zip(screenshots, result).map {
        $0.0.moa.url = $0.1
      }
      screenshots.forEach {
        base.screenshortsStackView.addArrangedSubview($0)
      }
      base.layoutIfNeeded()
    }
  }
}

extension SearchResultCell: CellContentClassIdentifiable {
}
