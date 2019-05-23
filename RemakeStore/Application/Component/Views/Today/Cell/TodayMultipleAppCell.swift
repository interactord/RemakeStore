//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class TodayMultipleAppCell: BaseTodayCell {

  var topConstraint: NSLayoutConstraint!

  private(set) lazy var todayMultipleAppListView: TodayMultipleAppListView = {
    let listView = TodayMultipleAppListView()
    return listView
  }()

  private let spacingView: UIView = {
    return ViewBuilder()
      .setHeightAnchor(20)
      .build()
  }()

  private lazy var stackView: UIStackView = {
    return StackViewBuilder(
      arrangedSubViews: [
        categoryLabel,
        titleLabel,
        spacingView,
        todayMultipleAppListView
      ])
      .setAxis(.vertical)
      .build()
  }()

  override func setupSubView() {
    super.setupSubView()
    addSubview(stackView)
  }

  override func setupConstant() {
    super.setupConstant()
    stackView
      .setLeadingAnchor(leadingAnchor, padding: thumbnailPaddingTop)
      .setBottomAnchor(bottomAnchor, padding: thumbnailPaddingTop)
      .setTrailingAnchor(trailingAnchor, padding: thumbnailPaddingTop)

    topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: thumbnailPaddingTop)
    topConstraint.isActive = true

  }

  override func reset() {
    super.reset()
    categoryLabel.text = nil
    titleLabel.text = nil
    todayMultipleAppListView.feedResultViewModels = nil
  }

}

extension TodayMultipleAppCell: TodayItemViewModelBindable {
  func bind(to viewModel: TodayItemViewModeling) {
    viewModel.outputs.category
      .asDriverJustComplete()
      .drive(categoryLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.title
      .asDriverJustComplete()
      .drive(titleLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.feedResultViewModels
      .asDriverJustComplete()
      .drive(todayMultipleAppListView.rx.updateFeedResultViewModels)
      .disposed(by: disposeBag)
  }
}

extension TodayMultipleAppCell: FullScreenLayoutCellAnimatedable {
  var thumbnailHeight: CGFloat {
    return 436
  }

  var fullScreenHeight: CGFloat {
    return UIScreen.main.bounds.height
  }

  var thumbnailPaddingTop: CGFloat {
    return 24
  }

  var fullScreenPaddingTop: CGFloat {
    return 48
  }

}

extension TodayMultipleAppCell: CellContentClassIdentifiable {
}
