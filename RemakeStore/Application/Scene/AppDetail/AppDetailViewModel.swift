//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

protocol AppDetailViewModelInput {
  var appId: PublishSubject<Int> { get }
}

protocol AppDetailViewModelOutput {
  var lookupViewModel: Observable<LookupViewModeling> { get }
  var screenshotViewModels: Observable<[ScreenshotViewModeling]> { get }
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

  let appId: PublishSubject<Int> = .init()

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
      $0.map {
        ScreenshotViewModel(withScreenshot: $0)
      }
    }

  // MARK: - Private

  private lazy var lookupRepository = AnyRepository<AppResult>(
    base: LookupRepository(
      httpClient: self.service.httpClient
    ))

  private lazy var lookupData: Observable<AppResult.AppInformation?> = appId.flatMapLatest { [unowned self] appId in
    self.lookupRepository.read(with: LookupReadParameter(withAppId: appId))
  }.map { [unowned self] result -> AppResult.AppInformation? in
    self.service.logger.log(level: .info, message: result)
    switch result {
    case .noContent:
      return nil
    case .value(let appResult):
      return appResult.results.first
    }
  }

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
  }
}
