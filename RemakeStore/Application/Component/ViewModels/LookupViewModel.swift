//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol LookupViewModelOutput {
  var appInformation: Observable<AppResult.Lookup> { get }
  var result: AppResult.Lookup { get }
}

protocol LookupViewModeling {
  var outputs: LookupViewModelOutput { get }
}

protocol LookupViewModelBindable {
  func bind(to viewModel: LookupViewModeling)
}

typealias LookupViewModelType =
  LookupViewModelOutput & LookupViewModeling

class LookupViewModel: LookupViewModelType {

  // MARK: - Inputs & Outputs

  var outputs: LookupViewModelOutput {
    return  self
  }

  // MARK: - Outputs

  var appInformation: Observable<AppResult.Lookup>
  var result: AppResult.Lookup

  init(withResult result: AppResult.Lookup) {
    self.appInformation = Observable.just(result).observeOn(MainScheduler.asyncInstance)
    self.result = result
  }
}
