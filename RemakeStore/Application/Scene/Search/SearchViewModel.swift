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
  var searchViewModels: Observable<[LookupViewModeling]> { get }
}

protocol SearchViewModeling {
  var inputs: SearchViewModelInput { get }
  var outputs: SearchViewModelOutput { get }
}

typealias SearchViewModelType =
  SearchViewModelInput & SearchViewModelOutput & SearchViewModeling

class SearchViewModel: ServiceViewModel, SearchViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: SearchViewModelInput {
    return self
  }
  var outputs: SearchViewModelOutput {
    return self
  }

  // MARK: - Input

  var searchText: BehaviorSubject<String> = .init(value: "")

  // MARK: - Outputs
  lazy var searchViewModels: Observable<[LookupViewModeling]> = searchData
    .ignoreNil()
    .map {
      $0.results.map {
        LookupViewModel(withResult: $0)
      }
    }
    .observeOn(MainScheduler.instance)

  // MARK: - Private

  private lazy var searchData = self.searchText
    .ignoreEmpty()
    .flatMapLatest { [unowned self] term in
      self.searchRepository.read(with: SearchReadParameter(withTerm: term))
    }.map { result -> AppResult? in
      switch result {
      case .noContent:
        return nil
      case .value(let appResult):
        return appResult
      }
    }

  // MARK: - Protocol Variables

  let service: Service
  let searchRepository: AnyRepository<AppResult>

  // MARK: - Initializing

  init(with service: Service, searchRepository: AnyRepository<AppResult>) {
    self.service = service
    self.searchRepository = searchRepository
  }
}
