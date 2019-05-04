//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

class TodayViewModel: ServiceViewModel {
  let service: Service

  required init(with service: Service) {
    self.service = service
  }
}
