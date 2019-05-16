//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class TodayController: BaseController {

  // MARK: - ViewModel

  var viewModel: TodayViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  override func setupNavigation() {
    super.setupNavigation()

    navigationItem.title = "Today"
  }

}

extension TodayController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    print("TodayController")
  }
}
