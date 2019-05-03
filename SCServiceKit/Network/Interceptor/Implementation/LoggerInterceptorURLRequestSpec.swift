//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import Foundation

import RxSwift
@testable import SCServiceKit

class LoggerInterceptorURLRequestSpec: XCTestCase {

  var disposeBag: DisposeBag!
  var sut: LoggerInterceptorURLRequest?

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
  }

  override func tearDown() {
    super.tearDown()
    disposeBag = nil
  }

  func test_interceptor() {

    guard let url = URL(string: "http://test.com") else {
      fatalError("Should be not nil")
    }

    let expectedRequest = URLRequest(url: url)
    let appLogger = AppLogger()
    let expectedCall = XCTestExpectation(description: "called subscribe")
    sut = LoggerInterceptorURLRequest(logger: appLogger)

    guard
      let sut = sut,
      let disposeBag = disposeBag
      else {
        fatalError("Should be not nil")
    }

    let interceptors = InterceptorChain<URLRequest>(
      interceptors: [AnyInterceptor<URLRequest>(base: sut)],
      input: expectedRequest
    )

    sut.intercept(chain: interceptors)
      .subscribe(onNext: { request in
        XCTAssertNotNil(request)
        XCTAssertEqual(expectedRequest, request)
        expectedCall.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)
  }
}
