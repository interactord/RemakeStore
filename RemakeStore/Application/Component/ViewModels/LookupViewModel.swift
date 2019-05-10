//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol LookupViewModelInput {
}

protocol LookupViewModelOutput {
  var appInformation: Observable<AppResult.Lookup> { get }
  var result: AppResult.Lookup { get }
}

protocol LookupViewModeling {
  var inputs: LookupViewModelInput { get }
  var outputs: LookupViewModelOutput { get }
}

protocol LookupViewModelBindable {
  func bind(to viewModel: LookupViewModeling)
}

typealias LookupViewModelType =
  LookupViewModelInput & LookupViewModelOutput & LookupViewModeling

class LookupViewModel: LookupViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: LookupViewModelInput {
    return self
  }
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
