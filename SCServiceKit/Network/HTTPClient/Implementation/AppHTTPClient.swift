//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

public final class AppHTTPClient {

  // MARK: - Private

  private let transformer: AnyTransformer<Endpoint, URLRequest>
  private let networkAdapter: NetworkAdapter
  private let requestChain: InterceptorChain<URLRequest>
  private let responseChain: InterceptorChain<Response>
  private let httpErrorHandler: HTTPErrorHandler

  // MARK: - Initializing

  public init(
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

  public func request<T: Deserializable>(endpoint: Endpoint) -> Observable<ResultContent<T>> {
    let requestChain = self.requestChain
    let networkAdapter = self.networkAdapter
    let responseChain = self.responseChain
    let httpErrorHandler = self.httpErrorHandler

    return transformer
      .rx_transform(object: endpoint)
      .flatMap { requestChain.proceed(object: $0) }
      .flatMap { networkAdapter.rx_send(request: $0) }
      .flatMap { responseChain.proceed(object: $0) }
      .flatMap { response -> Observable<ResultContent<T>> in

        if false == response.succeed {
          return Observable.error(httpErrorHandler.handle(response: response))
        }

        guard let data = response.data else {
          return Observable.just(ResultContent.noContent)
        }

        do {
          let object = try T(data: data)
          return Observable.just(ResultContent.value(object))
        } catch {
          return Observable.error(error)
        }
      }
  }

  public func request(endpoint: Endpoint) -> Observable<Response> {
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
