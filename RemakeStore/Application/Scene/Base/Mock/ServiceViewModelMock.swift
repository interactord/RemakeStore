//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

@testable import RemakeStore

class ServiceViewModelMock: ServiceViewModel {
  var service: Service

  init(with service: Service) {
    self.service = service
  }
}
