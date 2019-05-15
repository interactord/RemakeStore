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
  var socialAppViewModels: Observable<[SocialAppViewModeling]> { get }
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

  private(set) lazy var appsGroups: Observable<[FeedViewModeling]> = Observable
    .zip([topGrossing, newGames, topFree])

  private(set) lazy var socialAppViewModels: Observable<[SocialAppViewModeling]> = {
    let socialApps = self.socialApps
    return socialApps.map {
      $0.map {
        SocialAppViewModel(withSocialApp: $0)
      }
    }
  }()
  // MARK: - Private

  private let rssRepository: RssRepository
  private let interactordRepository: InteractordRepository

  private lazy var topGrossing: Observable<FeedViewModeling> = self.fetchApps
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

  private lazy var newGames: Observable<FeedViewModeling> = self.fetchApps
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

  private lazy var topFree: Observable<FeedViewModeling> = self.fetchApps
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

  private lazy var socialApps: Observable<[SocialApp]> = {
    let fetchApps = self.fetchApps
    let interactordRepository = self.interactordRepository

    return fetchApps.flatMapLatest { _ in
      interactordRepository.socialApp()
    }.map { result -> [SocialApp]? in
      switch result {
      case .noContent:
        return nil
      case .value(let socialApps):
        return socialApps
      }
    }.ignoreNil()
  }()
  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  init(with service: Service, rssRepository: RssRepository, interactordRepository: InteractordRepository) {
    self.service = service
    self.rssRepository = rssRepository
    self.interactordRepository = interactordRepository
  }
}
