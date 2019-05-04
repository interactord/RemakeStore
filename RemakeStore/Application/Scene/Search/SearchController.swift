//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class SearchController: BaseController {

  // MARK: - ViewModel

  var viewModel: SearchViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }

}

extension SearchController: ViewModelBased {

  func bindViewModel() {
    print("SearchController")
  }
}
