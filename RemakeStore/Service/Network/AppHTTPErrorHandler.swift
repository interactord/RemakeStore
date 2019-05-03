//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct AppHTTPErrorHandler { }

extension AppHTTPErrorHandler: HTTPErrorHandler {

  // MARK: - functions for protocol
  public func handle(response: Response) -> Error {
    return NetworkError(error: nil)
  }

}
