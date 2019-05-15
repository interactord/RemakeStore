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
  var appsGroups: Observable<[AppsGroup]> { get }
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

  lazy var appsGroups = Observable
    .zip(topGrossing, newGames, topFree)
    .map { [$0, $1, $2] }

  // MARK: - Private

  let rssRepository: RssRepository

  lazy var topGrossing = self.fetchApps
    .flatMapLatest { [unowned self] _ in
      self.rssRepository.topGrossing()
    }.map { result -> AppsGroup? in
      switch result {
      case .noContent:
        return nil
      case .value(let appGroup):
        return appGroup
      }
    }.ignoreNil()

  lazy var newGames = self.fetchApps
    .flatMapLatest { [unowned self] _ in
      self.rssRepository.newGames()
    }.map { result -> AppsGroup? in
      switch result {
      case .noContent:
        return nil
      case .value(let appGroup):
        return appGroup
      }
    }.ignoreNil()

  lazy var topFree = self.fetchApps
    .flatMapLatest { [unowned self] _ in
      self.rssRepository.topFree()
    }.map { result -> AppsGroup? in
      switch result {
      case .noContent:
        return nil
      case .value(let appGroup):
        return appGroup
      }
    }.ignoreNil()

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  init(with service: Service, rssRepository: RssRepository) {
    self.service = service
    self.rssRepository = rssRepository
  }
}
