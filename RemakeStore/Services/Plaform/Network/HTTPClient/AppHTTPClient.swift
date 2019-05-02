//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

final class AppHTTPClient {

  // MARK: - Private

  private let transformer: AnyTransformer<Endpoint, URLRequest>
  private let networkAdapter: NetworkAdapter
  private let requestChain: InterceptorChain<URLRequest>
  private let responseChain: InterceptorChain<Response>
  private let httpErrorHandler: HTTPErrorHandler

  // MARK: - Initializing

  init(
    transformer: AnyTransformer<Endpoint, URLRequest>,
    networkAdapter: NetworkAdapter,
    requestChain: InterceptorChain<URLRequest>,
    responseChain: InterceptorChain<Response>,
    httpErrorHandler: HTTPErrorHandler
  ) {
    self.transformer = transformer
    self.networkAdapter = networkAdapter
    self.requestChain = requestChain
    self.responseChain = responseChain
    self.httpErrorHandler = httpErrorHandler
  }

}

extension AppHTTPClient: HTTPClient {

  // MARK: - functions for protocol

  func request(endpoint: Endpoint) -> Observable<Response> {
    let requestChain = self.requestChain
    let networkAdapter = self.networkAdapter
    let responseChain = self.responseChain

    return transformer
      .rx_transform(object: endpoint)
      .flatMap { requestChain.proceed(object: $0) }
      .flatMap { networkAdapter.rx_send(request: $0) }
      .flatMap { responseChain.proceed(object: $0) }
  }
}
