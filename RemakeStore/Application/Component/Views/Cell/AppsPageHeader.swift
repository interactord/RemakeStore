//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit

class AppsPageHeader: BaseCollectionReusableView {

  lazy var appsHeaderHorizontalListView: AppsHeaderHorizontalListView = {
    let horizontalView = AppsHeaderHorizontalListView(withLayoutStyle: .horizontalSnapping)
    self.addSubview(horizontalView)
    return horizontalView
  }()

  override func setupConstant() {
    super.setupConstant()
    appsHeaderHorizontalListView.fillSuperView()
  }
}

extension AppsPageHeader: CellContentClassIdentifiable {
}
