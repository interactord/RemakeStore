//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

class SearchViewModel: ServiceViewModel {
  let service: Service

  let searchText: BehaviorSubject<String> = .init(value: "")

  lazy var searchRepository = AnyRepository<SearchResult>(base: SearchResultRepository(httpClient: self.service.httpClient))

  lazy var searchResult = self.searchText.flatMapLatest { [unowned self] term in
    self.searchRepository.read(with: SearchResultReadParameter(withTerm: term))
  }.map { result -> [SearchResultCellViewModel] in
    switch result {
    case .noContent:
      return []
    case .value(let searchResult):
      return searchResult.results.map {
        SearchResultCellViewModel(withResult: $0)
      }
    }
  }
  .observeOn(MainScheduler.instance)

  required init(with service: Service) {
    self.service = service
  }
}
