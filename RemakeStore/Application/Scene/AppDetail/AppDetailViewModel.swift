//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

protocol AppDetailViewModelInput {
  var appId: BehaviorSubject<Int?> { get }
}

protocol AppDetailViewModelOutput {
  var lookupViewModel: Observable<LookupViewModeling> { get }
  var screenshotViewModels: Observable<[ScreenshotViewModeling]> { get }
  var reviewsEntryModels: Observable<[ReviewsEntryViewModeling]> { get }
}

protocol AppDetailViewModeling {
  var inputs: AppDetailViewModelInput { get }
  var outputs: AppDetailViewModelOutput { get }
}

typealias AppDetailViewModelType =
  AppDetailViewModelInput & AppDetailViewModelOutput & AppDetailViewModeling

class AppDetailViewModel: ServiceViewModel, AppDetailViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: AppDetailViewModelInput {
    return self
  }

  var outputs: AppDetailViewModelOutput {
    return self
  }

  // MARK: - Inputs

  var appId: BehaviorSubject<Int?> = .init(value: nil)

  // MARK: - Outputs

  lazy var lookupViewModel: Observable<LookupViewModeling> = lookupData
    .ignoreNil()
    .map {
      LookupViewModel(withResult: $0)
    }

  lazy var screenshotViewModels: Observable<[ScreenshotViewModeling]> = lookupData
    .ignoreNil()
    .map { $0.screenshotUrls }
    .ignoreNil()
    .map {
      $0.map { ScreenshotViewModel(withScreenshot: $0) }
    }

  lazy var reviewsEntryModels: Observable<[ReviewsEntryViewModeling]> = reviewsData
    .ignoreNil()
    .map { $0.feed.entry }
    .ignoreNil()
    .map {
      $0.map { ReviewsEntryViewModel(withEntry: $0) }
    }

  // MARK: - Private

  private lazy var lookupData: Observable<Lookup.Information?> = appId
    .asObservable()
    .ignoreNil()
    .flatMapLatest { [unowned self] appId in
      self.lookupRepository.read(with: LookupReadParameter(withAppId: appId))
    }
    .map { result -> Lookup.Information? in
      switch result {
      case .noContent:
        return nil
      case .value(let appResult):
        return appResult.results.first
      }
    }

  private lazy var reviewsData: Observable<Reviews?> = appId
    .asObservable()
    .ignoreNil()
    .flatMapLatest { [unowned self] appId in
      self.reviewsRepository.read(with: ReviewsReadParameter(withAppId: appId))
    }.map { result -> Reviews? in
      switch result {
      case .noContent:
        return nil
      case .value(let reviews):
        return reviews
      }
    }

  // MARK: - Protocol Variables

  let service: Service
  let lookupRepository: AnyRepository<Lookup>
  let reviewsRepository: AnyRepository<Reviews>

  // MARK: - Initializing

  init(with service: Service, lookupRepository: AnyRepository<Lookup>, reviewsRepository: AnyRepository<Reviews>) {
    self.service = service
    self.lookupRepository = lookupRepository
    self.reviewsRepository = reviewsRepository
  }
}
