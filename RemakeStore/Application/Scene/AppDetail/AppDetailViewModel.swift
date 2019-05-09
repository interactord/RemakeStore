//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

class AppDetailViewModel: ServiceViewModel {
  let service: Service

  let appId: PublishSubject<Int> = .init()

  required init(with service: Service) {
    self.service = service
  }
}
