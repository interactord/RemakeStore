//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

protocol SearchViewModelInput {
  var searchText: BehaviorSubject<String> { get }
}

protocol SearchViewModelOutput {
  var search: Observable<[LookupViewModel]> { get }
}

protocol SearchViewModelType {
  var inputs: SearchViewModelInput { get }
  var outputs: SearchViewModelOutput { get }
}

typealias SearchViewModelTypes =
  SearchViewModelInput & SearchViewModelOutput & SearchViewModelType

class SearchViewModel: ServiceViewModel, SearchViewModelTypes {

  // MARK: - Inputs & Outputs

  var inputs: SearchViewModelInput {
    return self
  }
  var outputs: SearchViewModelOutput {
    return  self
  }

  // MARK: - Input

  var searchText: BehaviorSubject<String> = .init(value: "")

  // MARK: - Outputs

  lazy var search = self.searchText.flatMapLatest { [unowned self] term in
    self.searchRepository.read(with: SearchReadParameter(withTerm: term))
  }.map { result -> [LookupViewModel] in
    switch result {
    case .noContent:
      return []
    case .value(let searchResult):
      return searchResult.results.map {
        LookupViewModel(withResult: $0)
      }
    }
  }
  .observeOn(MainScheduler.instance)

  // MARK: - Private

  private lazy var searchRepository = AnyRepository<AppResult>(
    base: SearchRepository(
      httpClient: self.service.httpClient
    ))

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
  }
}
