//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import RxSwift
import RxCocoa

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

extension AppsPageHeader {
  func bind(to viewModels: [SocialAppViewModeling]) {
    Observable.just(viewModels)
      .asDriverJustComplete()
      .drive(appsHeaderHorizontalListView.rx.updateSocialViewModels)
      .disposed(by: disposeBag)
  }
}

extension AppsPageHeader: CellContentClassIdentifiable {
}
