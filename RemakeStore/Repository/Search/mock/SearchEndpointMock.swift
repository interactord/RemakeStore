//
// Created by Scott Moon on 2019-05-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit
@testable import RemakeStore

enum SearchEndpointMock {

  case read(with: SearchReadParameter)

  // MARK: - Private

  private enum Constent {
    static let baseUrl = "http://localhost:7000"
    static let path = "search"
  }
}

extension SearchEndpointMock: Endpoint {

  // MARK: - functions for protocol

  public var baseURL: String {
    return Constent.baseUrl
  }

  public var path: String {
    return Constent.path
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
