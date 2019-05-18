//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

protocol TodayViewModelInput {
  var fetchToday: BehaviorSubject<Void?> { get }
}

protocol TodayViewModelOutput {
  var todayItemViewModels: Observable<[TodayItemViewModeling]> { get }
}

protocol TodayViewModeling {
  var inputs: TodayViewModelInput { get }
  var outputs: TodayViewModelOutput { get }
}

typealias TodayViewModelType =
  TodayViewModelInput & TodayViewModelOutput & TodayViewModeling

class TodayViewModel: ServiceViewModel, TodayViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: TodayViewModelInput {
    return self
  }

  var outputs: TodayViewModelOutput {
    return self
  }

  // MARK: - Inputs

  private(set) var fetchToday: BehaviorSubject<Void?> = .init(value: nil)

  // MARK: - Outputs
  private(set) lazy var todayItemViewModels: Observable<[TodayItemViewModeling]> = {
    let todayItems = self.todayItems

    return todayItems.map {
      $0.map {
        TodayItemViewModel(withTodayItem: $0)
      }
    }
  }()

  // MARK: - Private
  private lazy var todayItems: Observable<[TodayItem]> = {
    let fetchToday = self.fetchToday
    let interactordRepository = self.interactordRepository

    return fetchToday
      .ignoreNil()
      .flatMapLatest {
        interactordRepository.today()
      }
      .map { result -> [TodayItem]? in
        switch result {
        case .noContent:
          return nil
        case .value(let items):
          return items
        }
      }
      .ignoreNil()
  }()

  private let interactordRepository: InteractordRepository
  private let rssRepository: RssRepository

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  required init(with service: Service, interactordRepository: InteractordRepository, rssRepository: RssRepository) {
    self.service = service
    self.interactordRepository = interactordRepository
    self.rssRepository = rssRepository
  }
}
