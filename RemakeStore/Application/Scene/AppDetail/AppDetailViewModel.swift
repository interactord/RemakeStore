//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

class AppDetailViewModel: ServiceViewModel {

  let appId: PublishSubject<Int> = .init()

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
  }
}
