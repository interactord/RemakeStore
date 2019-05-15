//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit
import RxSwift
import RxCocoa

class AppsController: BaseController {

  // MARK: - ViewModel

  var viewModel: AppsViewModel!

  lazy var appGroupListView = AppsPageListView()

  // MARK: - Views

  private lazy var activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = ActivityIndicatorViewBuilder()
      .setColor(.black)
      .setHidesWhenStopped()
      .startAnimating()
      .build()
    return activityIndicatorView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

  }

  override func setupViews() {
    super.setupViews()
    view.backgroundColor = .white

    self.view.addSubview(activityIndicatorView)
    self.view.addSubview(appGroupListView)
  }

  override func setupConstraints() {
    super.setupConstraints()
    appGroupListView.fillSuperView()
  }

  override func setupNavigation() {
    super.setupNavigation()

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
      .drive(appGroupListView.rx.updateAppsGroups)
      .disposed(by: disposeBag)

  }
}
