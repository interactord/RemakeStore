//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct AppResponse {

  // MARK: - Private

  private let _request: URLRequest
  private let _data: Data?
  private let httpResponse: URLResponse?
  private let _error: Error?

  // MARK: - Initializing
  public init(request: URLRequest, data: Data? = nil, httpResponse: URLResponse? = nil, error: Error? = nil) {
    _request = request
    _data = data
    self.httpResponse = httpResponse
    _error = error
  }
}

extension AppResponse: Response {

  public var succeed: Bool {
    guard let httpResponse = httpResponse as? HTTPURLResponse else {
      return false
    }

    return httpResponse.statusCode >= HTTPStatusCode.ok.rawValue
      && httpResponse.statusCode < HTTPStatusCode.badRequest.rawValue
  }

  public var data: Data? {
    return _data
  }

  public var error: Error? {
    return _error
  }

  public var statusCode: HTTPStatusCode? {
    guard let httpResponse = httpResponse as? HTTPURLResponse else {
      return nil
    }
    return HTTPStatusCode(rawValue: httpResponse.statusCode)
  }

  public var request: URLRequest {
    return _request
  }

  public var headers: [String: Any]? {
    guard let httpResponse = httpResponse as? HTTPURLResponse else {
      return nil
    }
    return httpResponse.allHeaderFields as? [String: Any]
  }

}
