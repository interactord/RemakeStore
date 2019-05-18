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

  private lazy var stackView: UIStackView = {
    return StackViewBuilder(
      arrangedSubViews: [
        categoryLabel,
        titleLabel,
        todayMultipleAppListView
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
    stackView.fillSuperView(
      padding: .init(top: 24, left: 24, bottom: 24, right: 24)
    )
  }
}


extension TodayMultipleAppCell: CellContentClassIdentifiable {
}
