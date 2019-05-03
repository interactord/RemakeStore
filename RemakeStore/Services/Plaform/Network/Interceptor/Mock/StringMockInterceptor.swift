//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift
@testable import RemakeStore

struct StringMockInterceptor: Interceptor {

  // MARK: - Private

  private let string: String

  // MARK: - Initializing

  init(string: String) {
    self.string = string
  }

  func intercept(chain: InterceptorChain<String>) -> Observable<String> {
    if let input = chain.input {
      print("\(string) + \(input)")
    }
    return chain.proceed()
  }

}
