//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

protocol AppsViewModelInput {
  var fetchApps: BehaviorSubject<Void?> { get }
}

protocol AppsViewModelOutput {
  var appsGroups: Observable<[FeedViewModeling]> { get }
}

protocol AppsViewModeling {
  var inputs: AppsViewModelInput { get }
  var outputs: AppsViewModelOutput { get }
}

typealias AppsViewModelType =
  AppsViewModelInput & AppsViewModelOutput & AppsViewModeling

class AppsViewModel: ServiceViewModel, AppsViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: AppsViewModelInput {
    return self
  }

  var outputs: AppsViewModelOutput {
    return self
  }

  // MARK: - Inputs

  var fetchApps: BehaviorSubject<Void?> = .init(value: nil)

  // MARK: - Outputs

  lazy var appsGroups: Observable<[FeedViewModeling]> = Observable
    .zip([topGrossing, newGames, topFree])
  // MARK: - Private

  let rssRepository: RssRepository

  lazy var topGrossing: Observable<FeedViewModeling> = self.fetchApps
    .flatMapLatest { [unowned self] _ in
      self.rssRepository.topGrossing()
    }.map { result -> AppsGroup? in
      switch result {
      case .noContent:
        return nil
      case .value(let appGroup):
        return appGroup
      }
    }
    .ignoreNil()
    .map { FeedViewModel(withFeed: $0.feed) }

  lazy var newGames: Observable<FeedViewModeling> = self.fetchApps
    .flatMapLatest { [unowned self] _ in
      self.rssRepository.newGames()
    }.map { result -> AppsGroup? in
      switch result {
      case .noContent:
        return nil
      case .value(let appGroup):
        return appGroup
      }
    }
    .ignoreNil()
    .map { FeedViewModel(withFeed: $0.feed) }

  lazy var topFree: Observable<FeedViewModeling> = self.fetchApps
    .flatMapLatest { [unowned self] _ in
      self.rssRepository.topFree()
    }.map { result -> AppsGroup? in
      switch result {
      case .noContent:
        return nil
      case .value(let appGroup):
        return appGroup
      }
    }
    .ignoreNil()
    .map { FeedViewModel(withFeed: $0.feed) }

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  init(with service: Service, rssRepository: RssRepository) {
    self.service = service
    self.rssRepository = rssRepository
  }
}
