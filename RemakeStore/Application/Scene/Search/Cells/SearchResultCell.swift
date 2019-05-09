//
// Created by Scott Moon on 2019-05-08.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SCUIBuildKit
import SCLayoutKit
import moa

protocol SearchResultCellType {
  func bind(to: SearchResultCellViewModel)
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

  lazy var ratingsLabel: UILabel = {
    return LabelBuilder()
      .setText("611k")
      .build()
  }()

  lazy var getButton: UIButton = {
    return ButtonBuilder()
      .setTitle("GET")
      .setFont(DefaultTheme.Font.body)
      .setWidthAnchor(80)
      .setHeightAnchor(32)
      .setBackgroundColor(#colorLiteral(red: 0.9601849914, green: 0.9601849914, blue: 0.9601849914, alpha: 1))
      .setCornerRadius(16)
      .build()
  }()

  lazy var screenShots: [UIImageView] = {
    var views = [UIImageView]()

    for _ in 1...3 {
      let imageView = ImageViewBuilder()
        .setBackgroundColor(DefaultTheme.Color.placeHolderColor)
        .setContentMode(.scaleAspectFill)
        .setCornerRadius(8)
        .setClipToBounds(true)
        .setBorderWidth(0.6)
        .setBorderColor(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1))
        .build()
      views.append(imageView)
    }

    return views
  }()

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

  override func reset() {
    super.reset()
    appIconImageView.image = nil
    nameLabel.text = ""
    categoryLabel.text = ""
    ratingsLabel.text = ""
    screenShots.forEach {
      $0.image = nil
    }
  }
}

extension SearchResultCell: SearchResultCellType {

  // MARK: - functions for protocol

  func bind(to viewModel: SearchResultCellViewModel) {

    viewModel.outputs.appInformation
      .map { $0.trackName }
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.appInformation
      .map { $0.primaryGenreName }
      .bind(to: categoryLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.appInformation
      .map { "Rating: \($0.averageUserRating ?? 0)" }
      .bind(to: ratingsLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.appInformation
      .map { $0.artworkUrl100 }
      .bind(to: appIconImageView.rx.loadImage)
      .disposed(by: disposeBag)

    viewModel.outputs.appInformation
      .map { $0.screenshotUrls?[0] ?? "" }
      .bind(to: screenShots[0].rx.loadImage)
      .disposed(by: disposeBag)

    viewModel.outputs.appInformation
      .map {
        $0.screenshotUrls?.count ?? 0 > 1
          ? $0.screenshotUrls?[1] ?? ""
          : ""
      }
      .bind(to: screenShots[1].rx.loadImage)
      .disposed(by: disposeBag)

    viewModel.outputs.appInformation
      .map {
        $0.screenshotUrls?.count ?? 0 > 2
          ? $0.screenshotUrls?[2] ?? ""
          : ""
      }
      .bind(to: screenShots[2].rx.loadImage)
      .disposed(by: disposeBag)

  }

}

extension SearchResultCell: CellContentClassIdentifiable {
}

extension Reactive where Base: UIImageView {
  internal var loadImage: Binder<String> {
    return Binder(self.base) { base, result in
      base.moa.url = result
    }
  }
}
