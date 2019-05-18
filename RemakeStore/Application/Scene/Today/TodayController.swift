//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit
import RxSwift
import RxCocoa

class TodayController: BaseController {

  // MARK: - ViewModel

  var viewModel: TodayViewModel!

  // MARK: - Private

  private lazy var todayListView: TodayListView = {
    let listView = TodayListView()
    view.addSubview(listView)
    return listView
  }()

  private lazy var capView: UIView = {
    let capView = ViewBuilder()
      .setBackgroundColor(DefaultTheme.Color.secondaryColor)
      .setHeightAnchor(UIApplication.shared.statusBarFrame.height)
      .build()

    view.addSubview(capView)
    return capView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  override func setupConstraints() {
    super.setupConstraints()

    capView
      .setTopAnchor(view.topAnchor)
      .setLeadingAnchor(view.leadingAnchor)
      .setTrailingAnchor(view.trailingAnchor)

    todayListView
      .setTopAnchor(capView.bottomAnchor)
      .setLeadingAnchor(view.leadingAnchor)
      .setBottomAnchor(view.bottomAnchor)
      .setTrailingAnchor(view.trailingAnchor)
  }

}

extension TodayController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    viewWillAppearAction
      .asDriverJustComplete()
      .drive(viewModel.inputs.fetchToday)
      .disposed(by: disposeBag)

    viewModel.outputs.todayItemViewModels
      .asDriverJustComplete()
      .drive(todayListView.rx.updateTodayItemViewModels)
      .disposed(by: disposeBag)
  }
}
