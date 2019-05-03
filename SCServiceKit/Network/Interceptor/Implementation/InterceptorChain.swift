//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

final class InterceptorChain<T> {

  // MARK: - Private

  private var interceptors: [AnyInterceptor<T>]

  // MARK: - Public

  public var input: T?

  // MARK: - Initializing
  init(interceptors: [AnyInterceptor<T>], input: T?) {
    self.interceptors = interceptors
    self.input = input
  }

  convenience init() {
    self.init(interceptors: [AnyInterceptor<T>](), input: nil)
  }

  // MARK: - Public

  public func add(interceptor: AnyInterceptor<T>) -> InterceptorChain {
    interceptors.append(interceptor)

    return self
  }

  public func proceed(object: T? = nil) -> Observable<T> {
    if let object = object {
      return proceedNext(with: object)
    } else if let input = self.input {
      return proceedNext(with: input)
    }

    fatalError("You must set an input object to the chain (setter or in parameter of `proceed` method)")
  }

  // MARK: - Private

  private func proceedNext(with input: T) -> Observable<T> {
    guard let interceptor = self.interceptors.first else {
      return Observable.just(input)
    }

    var interceptors = self.interceptors
    interceptors.removeFirst()

    return interceptor.intercept(
      chain: InterceptorChain(interceptors: interceptors, input: input)
    )
  }
}
