//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
@testable import SCServiceKit

final class UserDecodableRepoMock {

  // MARK: - Private

  private let httpClient: HTTPClient

  // MARK: - Initializing

  init(httpClient: HTTPClient) {
    self.httpClient = httpClient
  }

}

extension UserDecodableRepoMock: Repository {

  // MARK: - Protocol functions
  func create(with parameter: RepositoryParameter?) -> Observable<ResultContent<UserDecodableMock>> {
    return httpClient.request(endpoint: UserEndpointMock.create)
  }

  func read(with parameter: RepositoryParameter?) -> Observable<ResultContent<UserDecodableMock>> {
    return httpClient.request(endpoint: UserEndpointMock.read)
  }

  func update(with parameter: RepositoryParameter?) -> Observable<ResultContent<UserDecodableMock>> {
    guard let userParameterMock = parameter as? UpdateUserParameterMock else {
      return Observable.error(TypeCastingError(developerMessage: "Parameter should be typed UpdateUserParameterMock"))
    }
    return httpClient.request(endpoint: UserEndpointMock.update(with: userParameterMock))
  }

  func delete(with parameter: RepositoryParameter?) -> Observable<ResultContent<UserDecodableMock>> {
    return httpClient.request(endpoint: UserEndpointMock.delete)
  }

}
