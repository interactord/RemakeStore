//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

protocol TodayViewModelInput {
}

protocol TodayViewModelOutput {
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

  // MARK: - Private

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
