//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

@testable import RemakeStore

enum UserEndpointMock {

  case read(with: ReadUserParameterMock)
  case update(with: UpdateUserParameterMock)

  private enum Constant {
    static let baseUrl = "http://localhost:7000"
    static let path = "user"
  }

  private enum Key {
    static let name = "name"
    static let surname = "surname"
    static let age = "age"
  }

}

extension UserEndpointMock: Endpoint {

  // MARK: - functions for protocol
  var baseURL: String {
    return Constant.baseUrl
  }

  var path: String {
    return Constant.path
  }

  var httpMethod: HTTPMethod {
    switch self {
    case .read:
      return HTTPMethod.GET
    case .update:
      return HTTPMethod.PUT
    }
  }

  var queryParameters: [String: String]? {
    switch self {
    case.read(let parameter):
      return [
        Key.name: parameter.name,
        Key.surname: parameter.surname,
        Key.age: parameter.age
      ]
    case .update(let parameter):
      return [
        Key.name: parameter.name,
        Key.surname: parameter.surname
      ]
    }
  }
}
