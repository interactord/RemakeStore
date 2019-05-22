//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol TodayDetailViewModelOutput {
  var todayItemViewModel: Observable<TodayItemViewModeling> { get }
}

protocol TodayDetailViewModeling {
  var outputs: TodayDetailViewModelOutput { get }
}

typealias TodayDetailViewModelType =
  TodayDetailViewModelOutput & TodayDetailViewModeling

class TodayDetailViewModel: ServiceViewModel, TodayDetailViewModelType {

  // MARK: - Protocol Variables

  var outputs: TodayDetailViewModelOutput {
    return self
  }

  // MARK: - Outputs

  var todayItemViewModel: Observable<TodayItemViewModeling>

  let service: Service

  // MARK: - Initializing

  required init(with service: Service, todayItemViewModel: TodayItemViewModeling) {
    self.service = service
    self.todayItemViewModel = Observable.just(todayItemViewModel)
  }
}
