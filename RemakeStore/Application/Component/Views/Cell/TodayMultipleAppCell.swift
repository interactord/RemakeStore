//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class TodayMultipleAppCell: BaseTodayCell {

  private lazy var todayMultipleAppListView: TodayMultipleAppListView = {
    let listView = TodayMultipleAppListView()
    listView.viewMode(to: .small)
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
    stackView.fillSuperView(
      padding: .init(top: 24, left: 24, bottom: 24, right: 24)
    )
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

extension TodayMultipleAppCell: CellContentClassIdentifiable {
}
