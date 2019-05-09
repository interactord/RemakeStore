//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class AppDetailController: BaseController {

  // MARK: - ViewModel

  var viewModel: AppDetailViewModel!

  var appId: Int!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
  }

}

extension AppDetailController: ViewModelBased {

  func bindViewModel() {

    Observable.just(appId)
      .bind(to: viewModel.appId)
      .disposed(by: disposeBag)

  }
}
