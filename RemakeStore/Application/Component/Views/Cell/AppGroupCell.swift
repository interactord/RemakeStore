//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class AppGroupCell: BaseCollectionViewCell {
  lazy var titleLable: UILabel = {
    return LabelBuilder()
      .setText("APP SECTION")
      .setFont(DefaultTheme.Font.title1)
      .build()
  }()

  let appsHorizontalListView = AppsHorizontalListView(withLayoutStyle: .horizontalSnapping)

  override func setupSubView() {
    super.setupSubView()
    addSubview(titleLable)
    addSubview(appsHorizontalListView)
  }

  override func setupConstant() {
    super.setupConstant()

    titleLable
      .setTopAnchor(topAnchor)
      .setLeadingAnchor(leadingAnchor, padding: 16)
      .setTrailingAnchor(trailingAnchor)

    appsHorizontalListView
      .setTopAnchor(titleLable.topAnchor)
      .setLeadingAnchor(leadingAnchor)
      .setBottomAnchor(bottomAnchor)
      .setTrailingAnchor(trailingAnchor)
  }

}

extension AppGroupCell: CellContentClassIdentifiable {
}
