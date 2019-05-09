//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit

class SearchController: BaseController {

  // MARK: - ViewModel

  var viewModel: SearchViewModel!

  // MARK: - Private

  private lazy var searchResultView: SearchResultView = {
    let searchResultView = SearchResultView()
    view.addSubview(searchResultView)
    return searchResultView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  override func setupConstraints() {
    super.setupConstraints()
    searchResultView.fillSuperView()
  }

}

extension SearchController: ViewModelBased {

  func bindViewModel() {
    print("SearchController")
  }
}
