//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit
import RxSwift
import RxCocoa

class ReviewCell: BaseCollectionViewCell {

  private lazy var titleLabel: UILabel = {
    let label = LabelBuilder()
      .setText("REVIEW TITLE")
      .setFont(DefaultTheme.Font.title3)
      .build()

    label.setContentHuggingPriority(.init(0), for: .horizontal)
    return label
  }()

  private lazy var authorLabel: UILabel = {
    return LabelBuilder()
      .setText("AUTHOR")
      .setTextAlignment(.right)
      .setFont(DefaultTheme.Font.body)
      .build()
  }()

  private lazy var bodyLabel: UILabel = {
    return LabelBuilder()
      .setText("REVIEW BODY\nREVIEW BODY\nREVIEW BODY")
      .setFont(DefaultTheme.Font.body)
      .setNumberOfLines(5)
      .build()
  }()

  fileprivate lazy var starsStackView: UIStackView = {
    var arrangedView = [UIView()]
    (0..<5).forEach { _ in
      let imgView = ImageViewBuilder()
        .setImage(#imageLiteral(resourceName: "Star-Active"))
        .setWidthAnchor(18)
        .setHeightAnchor(18)
        .build()
      arrangedView.insert(imgView, at: 0)
    }

    return StackViewBuilder(arrangedSubViews: arrangedView)
      .build()
  }()

  lazy var contentStackView: UIStackView = {

    ///---------------------------------
    /// [titleLabel] -8- [authorLabel]
    ///----------------------------------

    let titleAuthorWrap = StackViewBuilder(
      arrangedSubViews: [titleLabel, authorLabel]
    ).setSpacing(8).build()

    ///---------------------------------
    /// [titleLabel] -8- [authorLabel]
    ///  | 12
    /// [starsStackView]
    ///  | 12
    /// [bodyLabel]
    ///----------------------------------

    return StackViewBuilder(
      arrangedSubViews: [titleAuthorWrap, starsStackView, bodyLabel]
    ).setAxis(.vertical).setSpacing(12).build()

  }()

  override func setupSubView() {
    super.setupSubView()
    backgroundColor = DefaultTheme.Color.lightGrayColor
    layer.cornerRadius = 16
    clipsToBounds = true

    addSubview(contentStackView)
  }

  override func setupConstant() {
    super.setupConstant()

    titleLabel.setContentHuggingPriority(.init(0), for: .horizontal)
    contentStackView
      .setTopAnchor(topAnchor, padding: 20)
      .setLeadingAnchor(leadingAnchor, padding: 20)
      .setTrailingAnchor(trailingAnchor, padding: 20)
  }
}

extension ReviewCell: ReviewsEntryViewModelBindable {

  func bind(to viewModel: ReviewsEntryViewModeling) {
    viewModel.outputs.author
      .bind(to: authorLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.title
      .bind(to: titleLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.body
      .bind(to: bodyLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.rating
      .bind(to: self.rx.updateRating)
      .disposed(by: disposeBag)
  }
}

extension ReviewCell: CellContentClassIdentifiable {
}

// MARK: - RX Binder

extension Reactive where Base: ReviewCell {

  internal var updateRating: Binder<Int> {
    return Binder(self.base) { base, result in
      for (index, view) in base.starsStackView.arrangedSubviews.enumerated() {
        view.alpha = index >= result ? 0 : 1
      }
    }
  }
}
