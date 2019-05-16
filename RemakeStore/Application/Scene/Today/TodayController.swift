//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit

class TodayController: BaseController {

  // MARK: - ViewModel

  var viewModel: TodayViewModel!

  lazy var todayListView: TodayListView = {
    let listView = TodayListView()
    view.addSubview(listView)
    return listView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  override func setupConstraints() {
    super.setupConstraints()
    todayListView.fillSuperView()
  }

}

extension TodayController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    print("TodayController")
  }
}
