//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

final class InteractordRepository {

  // MARK: - Private

  private let httpClient: HTTPClient
  private let baseUrl: String

  // MARK: - Initializing

  init(httpClient: HTTPClient, baseUrl: String) {
    self.httpClient = httpClient
    self.baseUrl = baseUrl
  }

}

extension InteractordRepository {

  func socialApp() -> Observable<ResultContent<[SocialApp]>> {
    let endpoint = InteractordEndpoint(baseUrl: baseUrl, router: .socialApps)
    return httpClient.request(endpoint: endpoint)
  }
}
