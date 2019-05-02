//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct EndPointToURLRequestTransformer: Transformer {

  // MARK: - Protocol functions
  func transform(object: Endpoint) throws -> URLRequest {
    guard let url = finalURL(object: object) else {
      throw MalformedURLError()
    }

    var request = URLRequest(url: url)
    request.httpMethod = object.httpMethod.rawValue

    object.headers?.forEach {
      request.addValue($1, forHTTPHeaderField: $0)
    }

    if let bodyParameters = object.bodyParameters {
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
      } catch {
        throw SerializationError(error: error)
      }
    }

    return request

  }

  private func finalURL(object: Endpoint) -> URL? {
    guard
      let url = URL(string: object.baseURL)?.appendingPathComponent(object.path) else {
        return nil
    }

    var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false)

    if let queryParameters = object.queryParameters {
      urlComponent?.queryItems = queryParameters.map {
        URLQueryItem(name: $0, value: $1)
      }
    }

    return urlComponent?.url
  }
}
