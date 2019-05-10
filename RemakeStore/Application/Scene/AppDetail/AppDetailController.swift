//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import SCLayoutKit

class AppDetailController: BaseController {

  // MARK: - ViewModel

  var viewModel: AppDetailViewModel!

  // MARK: Public

  var appId: Int!

  private lazy var appDetailResultView: AppDetailResultView = {
    let resultView = AppDetailResultView()
    view.addSubview(resultView)
    return resultView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func setupConstraints() {
    super.setupConstraints()

    appDetailResultView.fillSuperView()
  }

  override func setupNavigation() {
    super.setupNavigation()
    navigationItem.largeTitleDisplayMode = .never
  }
}

extension AppDetailController: ViewModelBased {

  func bindViewModel() {

    let appId = self.appId

    viewWillAppearAction
      .asObservable()
      .map { appId }
      .ignoreNil()
      .bind(to: viewModel.inputs.appId)
      .disposed(by: disposeBag)

    viewModel.outputs.lookup
      .bind(to: appDetailResultView.rx.updateItems)
      .disposed(by: disposeBag)
  }
}
