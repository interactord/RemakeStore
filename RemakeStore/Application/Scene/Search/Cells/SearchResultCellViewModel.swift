//
//  SearchResultCellViewModel.swift
//  RemakeStore
//
//  Created by Scott Moon on 09/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol SearchResultCellViewModelInput {
}

protocol SearchResultCellViewModelOutput {
  var appInformation: Observable<AppResult.AppInformation> { get }
  var result: AppResult.AppInformation { get }
}

protocol SearchResultCellViewModelType {
  var inputs: SearchResultCellViewModelInput { get }
  var outputs: SearchResultCellViewModelOutput { get }
}

typealias SearchResultCellViewModelTypes =
  SearchResultCellViewModelInput & SearchResultCellViewModelOutput & SearchResultCellViewModelType

class SearchResultCellViewModel: SearchResultCellViewModelTypes {

  // MARK: - Inputs & Outputs

  var inputs: SearchResultCellViewModelInput {
    return self
  }
  var outputs: SearchResultCellViewModelOutput {
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
