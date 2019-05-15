//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct InteractordEndpoint {

  // MARK: - Private

  private let baseUrl: String
  private let router: InteractordEndpointRouter

  // MARK: - Initializing

  init(baseUrl: String, router: InteractordEndpointRouter) {
    self.baseUrl = baseUrl
    self.router = router
  }
}

extension InteractordEndpoint: Endpoint {

  // MARK: - functions for protocol
  public var baseURL: String {
    return baseUrl
  }

  public var path: String {
    switch router {
    case .socialApps:
      return "apps-banner/appsHeadBanner.json"
    }
  }

  public var httpMethod: HTTPMethod {
    return HTTPMethod.GET
  }

  public var queryParameters: [String: String]? {
    return nil
  }
}
