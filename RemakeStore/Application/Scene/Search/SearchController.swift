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

  var viewModel: SearchViewModeling!

  // MARK: - Views

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
    navigationItem.title = "Search"
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
  }

}

extension SearchController: ViewModelBased {

  // MARK: - functions for protocol

  func bindViewModel() {
    searchController.searchBar.rx
      .text.orEmpty
      .throttle(.seconds(2), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .bind(to: viewModel.inputs.searchText)
      .disposed(by: disposeBag)

    viewModel.outputs.search
      .bind(to: searchResultView.rx.updateItems)
      .disposed(by: disposeBag)

    searchResultView.rx
      .itemSelected
      .map { [unowned self] (indexPath: IndexPath) -> LookupViewModelOutput? in
        return self.searchResultView.items?[indexPath.item].outputs
      }
      .ignoreNil()
      .map { AppStep.appDetailIsRequired(appId: $0.result.trackId) }
      .subscribe(onNext: { step in
        print("step \(step)")
        self.steps.accept(step)
      }).disposed(by: disposeBag)
  }
}
