//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

class TodayDetailViewModel: ServiceViewModel {

  // MARK: - Protocol Variables

  let service: Service
  let todayItemViewModel: TodayItemViewModeling

  // MARK: - Initializing

  required init(with service: Service, todayItemViewModel: TodayItemViewModeling) {
    self.service = service
    self.todayItemViewModel = todayItemViewModel
  }
}
