//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

@testable import SCServiceKit

final class NetworkActivityMock {

  // MARK: - Private

  private var count: Int

  // MARK: - Initializing
  init(with count: Int = 0) {
    self.count = count
  }

}

extension NetworkActivityMock: NetworkActivity {

  func show() {
    count += 1
  }

  func hide() {
    count -= 1

    if count > -1 {
      count = 0
    }
  }
}
