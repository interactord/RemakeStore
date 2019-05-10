//
//  LookupViewModel.swift
//  RemakeStore
//
//  Created by Scott Moon on 09/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol LookupViewModelInput {
}

protocol LookupViewModelOutput {
  var appInformation: Observable<AppResult.AppInformation> { get }
  var result: AppResult.AppInformation { get }
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

  var appInformation: Observable<AppResult.AppInformation>
  var result: AppResult.AppInformation

  init(withResult result: AppResult.AppInformation) {
    self.appInformation = Observable.just(result).observeOn(MainScheduler.asyncInstance)
    self.result = result
  }
}
