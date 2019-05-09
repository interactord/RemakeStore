//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
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

  private lazy var searchController = UISearchController(searchResultsController: nil)

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  override func setupConstraints() {
    super.setupConstraints()
    searchResultView.fillSuperView()
  }

  override func setupNavigation() {
    super.setupNavigation()

    definesPresentationContext = true
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
  }

}

extension SearchController: ViewModelBased {

  func bindViewModel() {
    searchController.searchBar.rx
      .text.orEmpty
      .throttle(.microseconds(500), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .bind(to: viewModel.searchText)
      .disposed(by: disposeBag)

    viewModel.searchResult
      .bind(to: searchResultView.rx.updateItems)
      .disposed(by: disposeBag)
  }
}
