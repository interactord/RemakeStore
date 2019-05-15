//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct ITunesEndpoint {

  // MARK: - Private

  private let baseUrl: String
  private let router: ITunesEndpointRouter

  // MARK: - Initializing

  init(baseUrl: String, router: ITunesEndpointRouter) {
    self.baseUrl = baseUrl
    self.router = router
  }
}

extension ITunesEndpoint: Endpoint {

  // MARK: - functions for protocol

  public var baseURL: String {
    return baseUrl
  }

  public var path: String {
    switch router {
    case .search:
      return "search"
    case .lookup:
      return "lookup"
    case .review(let appId):
      return "rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json"
    }
  }

  public var httpMethod: HTTPMethod {
    return HTTPMethod.GET
  }

  public var queryParameters: [String: String]? {
    switch router {
    case .search(let term):
      return makeSearchParameter(term)
    case .lookup(let appId):
      return makeLookupParameter(appId)
    case .review:
      return makeReviewParameter()
    }
  }
}

extension ITunesEndpoint {
  private func makeSearchParameter(_ term: String) -> [String: String] {
    return [
      "term": term,
      "entity": "software"
    ]
  }

  private func makeLookupParameter(_ appId: String) -> [String: String] {
    return [
      "id": "\(appId)"
    ]
  }

  private func makeReviewParameter() -> [String: String] {
    return [
      "l": "en",
      "cc": "us"
    ]
  }
}
