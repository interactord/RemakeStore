//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct MalformedURLError {

  private enum Constant {
    static let translationKet = "error.global.network"
  }

}

extension MalformedURLError: ErrorType {

  // MARK: - Protocol Variables
  var raw: Error? {
    return nil
  }
  var messageKey: String {
    return Constant.translationKet
  }

}
