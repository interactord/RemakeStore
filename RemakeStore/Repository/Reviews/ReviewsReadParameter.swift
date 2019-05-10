//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct ReviewsReadParameter: RepositoryParameter {

  // MARK: Public

  let appId: Int

  // MARK: - Initializing

  init(withAppId appId: Int) {
    self.appId = appId
  }
}
