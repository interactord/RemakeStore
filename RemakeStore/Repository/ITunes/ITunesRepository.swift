//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
import SCServiceKit

final class ITunesRepository {

  // MARK: - Private

  private let httpClient: HTTPClient
  private let baseUrl: String

  // MARK: - Initializing

  init(httpClient: HTTPClient, baseUrl: String) {
    self.httpClient = httpClient
    self.baseUrl = baseUrl
  }
}

extension ITunesRepository {

  func search(term: String) -> Observable<ResultContent<Lookup>> {
    let endpoint = ITunesEndpoint(baseUrl: baseUrl, router: .search(term: term))
    return httpClient.request(endpoint: endpoint)
  }

  func lookup(appId: String) -> Observable<ResultContent<Lookup>> {
    let endpoint = ITunesEndpoint(baseUrl: baseUrl, router: .lookup(appId: appId))
    return httpClient.request(endpoint: endpoint)
  }

  func review(appId: String) -> Observable<ResultContent<Reviews>> {
    let endpoint = ITunesEndpoint(baseUrl: baseUrl, router: .review(appId: appId))
    return httpClient.request(endpoint: endpoint)
  }
}
