//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

class AppDetailViewModel: ServiceViewModel {

  let appId: PublishSubject<Int> = .init()

  lazy var appDetail = appId.flatMapLatest { [unowned self] appId in
    self.appDetailRepository.read(with: AppDetailReadParameter(withAppId: appId))
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

  private lazy var appDetailRepository = AnyRepository<AppResult>(
    base: AppDetailRepository(
      httpClient: self.service.httpClient
    ))

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
  }
}
