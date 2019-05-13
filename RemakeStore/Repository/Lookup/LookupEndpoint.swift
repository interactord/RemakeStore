//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

enum LookupEndpoint {

  case read(with: LookupReadParameter)

  // MARK: - Private

  private enum Constant {
    static let baseUrl = "https://itunes.apple.com"
    static let path = "lookup"
  }

}

extension LookupEndpoint: Endpoint {

  // MARK: - functions for protocol

  public var baseURL: String {
    return Constant.baseUrl
  }

  public var path: String {
    return Constant.path
  }

  public var httpMethod: HTTPMethod {
    switch self {
    case .read:
      return HTTPMethod.GET
    }
  }
  public var queryParameters: [String: String]? {
    switch self {
    case .read(let parameter):
      return parameter.query
    }
  }
}
