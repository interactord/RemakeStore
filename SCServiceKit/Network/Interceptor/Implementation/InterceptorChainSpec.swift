//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
@testable import SCServiceKit

class InterceptorChainSpec: XCTestCase {
  var disposeBag: DisposeBag?
  var sut: InterceptorChain<String>?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    disposeBag = nil
    sut = nil
  }

  func test_inject_input_proceed() {
    disposeBag = DisposeBag()
    let mock = StringMockInterceptor(string: "Test")
    let interceptor = AnyInterceptor<String>(base: mock)
    let expectedCall = XCTestExpectation(description: "call proceed")
    sut = InterceptorChain<String>()

    guard
      let disposeBag = disposeBag,
      let sut = sut
      else {
        fatalError("Should be not nil")
    }

    sut.input = "Test"
    sut
      .add(interceptor: interceptor)
      .proceed()
      .subscribe(onNext: { str in
        print(str)
        expectedCall.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)
  }

  func test_inject_object_proceed() {
    disposeBag = DisposeBag()
    let mock = StringMockInterceptor(string: "Test")
    let interceptor = AnyInterceptor<String>(base: mock)
    let expectedCall = XCTestExpectation(description: "call proceed")
    sut = InterceptorChain<String>()

    guard
      let disposeBag = disposeBag,
      let sut = sut
      else {
        fatalError("Should be not nil")
    }

    sut
      .add(interceptor: interceptor)
      .proceed(object: "Start")
      .subscribe(onNext: { str in
        print(str)
        expectedCall.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)
  }
}
