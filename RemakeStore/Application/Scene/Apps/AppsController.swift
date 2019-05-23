//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit
import RxSwift
import RxCocoa
import RxFlow

class AppsController: BaseController {

  // MARK: - ViewModel

  var viewModel: AppsViewModeling!

  lazy var appGroupListView = AppsPageListView()

  // MARK: - Views

  override func setupViews() {
    super.setupViews()
    view.backgroundColor = .white
    self.view = appGroupListView
    appGroupListView.bind(to: steps)
  }

  override func setupConstraints() {
    super.setupConstraints()
  }

  override func setupNavigation() {
    super.setupNavigation()

    definesPresentationContext = true
    navigationItem.title = "Apps"
  }
}

extension AppsController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    viewWillAppearAction
      .bind(to: viewModel.inputs.fetchApps)
      .disposed(by: disposeBag)

    viewModel.outputs.appsGroups
      .asDriverJustComplete()
      .drive(appGroupListView.rx.updateFeedViewModels)
      .disposed(by: disposeBag)

    viewModel.outputs.socialAppViewModels
      .asDriverJustComplete()
      .drive(appGroupListView.rx.updateSocialAppViewModels)
      .disposed(by: disposeBag)
  }
}
