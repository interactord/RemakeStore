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
  var lookup: Observable<LookupViewModeling> { get }
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
    return  self
  }

  // MARK: - Inputs

  let appId: PublishSubject<Int> = .init()

  // MARK: - Outputs

  lazy var lookup: Observable<LookupViewModeling> = appId.flatMapLatest { [unowned self] appId in
    self.lookupRepository.read(with: LookupReadParameter(withAppId: appId))
  }.map { [unowned self] result -> AppResult.AppInformation? in
    self.service.logger.log(level: .info, message: result)
    switch result {
    case .noContent:
      return nil
    case .value(let appResult):
      return appResult.results.first
    }
  }.ignoreNil()
    .map { LookupViewModel(withResult: $0) }

  // MARK: - Private

  private lazy var lookupRepository = AnyRepository<AppResult>(
    base: LookupRepository(
      httpClient: self.service.httpClient
    ))

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
  }
}
