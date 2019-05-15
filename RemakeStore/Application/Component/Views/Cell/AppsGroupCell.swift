//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class AppsGroupCell: BaseCollectionViewCell {
  lazy var titleLabel: UILabel = {
    return LabelBuilder()
      .setText("APP SECTION")
      .setFont(DefaultTheme.Font.title1)
      .build()
  }()

  let appsHorizontalListView = AppsHorizontalListView(withLayoutStyle: .horizontalSnapping)

  override func setupSubView() {
    super.setupSubView()
    addSubview(titleLabel)
    addSubview(appsHorizontalListView)
  }

  override func setupConstant() {
    super.setupConstant()

    titleLabel
      .setTopAnchor(topAnchor)
      .setLeadingAnchor(leadingAnchor, padding: 16)
      .setTrailingAnchor(trailingAnchor)

    appsHorizontalListView
      .setTopAnchor(titleLabel.bottomAnchor)
      .setLeadingAnchor(leadingAnchor)
      .setBottomAnchor(bottomAnchor)
      .setTrailingAnchor(trailingAnchor)
  }

}

extension AppsGroupCell: FeedViewModelBindable {
  func bind(to viewModel: FeedViewModeling) {
    viewModel.outputs.title
      .asDriverJustComplete()
      .drive(titleLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.outputs.feedResultViewModel
      .asDriverJustComplete()
      .drive(appsHorizontalListView.rx.updateFeedResults)
      .disposed(by: disposeBag)
 }
}

extension AppsGroupCell: CellContentClassIdentifiable {
}
