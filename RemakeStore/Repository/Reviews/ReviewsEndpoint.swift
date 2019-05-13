//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

enum ReviewsEndpoint {

  case read(with: ReviewsReadParameter)

  // MARK: - Private

  private enum Constant {
    static let baseUrl = "https://itunes.apple.com"
    static let path = "rss/customerreviews"
  }

}

extension ReviewsEndpoint: Endpoint {

  // MARK: - functions for protocol
  public var baseURL: String {
    return Constant.baseUrl
  }

  public var path: String {
    let path = Constant.path

    switch self {
    case .read(let parameter):
      return path + "/page=1/id=\(parameter.appId)/sortby=mostrecent/json"
    }
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
