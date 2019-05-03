//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct MalformedURLError {

  private enum Constant {
    static let translationKet = "error.global.network"
  }

  public init() { }

}

extension MalformedURLError: ErrorType {

  // MARK: - Protocol Variables
  public var raw: Error? {
    return nil
  }

  public var messageKey: String {
    return Constant.translationKet
  }

}
