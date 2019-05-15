//
// Created by Scott Moon on 2019-05-15.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct RssEndpoint {

  // MARK: - Private

  private let baseUrl: String

  private let route: RssEndpointRoute

  // MARK: - Initializing

  init(baseUrl: String, route: RssEndpointRoute) {
    self.baseUrl = baseUrl
    self.route = route
  }
}

extension RssEndpoint: Endpoint {

  // MARK: - functions for protocol

  public var baseURL: String {
    return baseUrl
  }

  public var path: String {
    return route.rawValue
  }

  public var httpMethod: HTTPMethod {
    return HTTPMethod.GET
  }

  public var queryParameters: [String: String]? {
    return nil
  }
}
