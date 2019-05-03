//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

@testable import SCServiceKit

struct EndpointMock: Endpoint {

  var baseURL: String
  var path: String
  var httpMethod: HTTPMethod
  var queryParameters: [String: String]?
  var headers: [String: String]?
  var bodyParameters: [String: Any]?

  init(
    baseURL: String,
    path: String,
    httpMethod: HTTPMethod,
    queryParameters: [String: String]? = nil,
    headers: [String: String]? = nil,
    bodyParameters: [String: Any]? = nil
  ) {
    self.baseURL = baseURL
    self.path = path
    self.httpMethod = httpMethod
    self.queryParameters = queryParameters
    self.headers = headers
    self.bodyParameters = bodyParameters
  }

}
