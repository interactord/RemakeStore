//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
@testable import RemakeStore

class OptionalTypeSpec: XCTestCase {

  var disposeBag: DisposeBag?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    disposeBag = nil
  }

  func test_inject_nil_ignoreNil() {

    let expectedCall = XCTestExpectation(description: "call completed")
    disposeBag = DisposeBag()
    guard let disposeBag = disposeBag else {
      fatalError("Should be not nil")
    }

    _ = Observable<String?>.just(nil)
      .ignoreNil()
      .subscribe { _ in
        print("끝")
        expectedCall.fulfill()
      }.disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)
  }

  func test_inject_string_ignoreNil() {

    let expectedCall = XCTestExpectation(description: "call completed")
    disposeBag = DisposeBag()
    guard let disposeBag = disposeBag else {
      fatalError("Should be not nil")
    }

    _ = Observable<String?>.just("test")
      .ignoreNil()
      .subscribe( onNext: { str in
        XCTAssertNotNil(str)
        expectedCall.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)
  }

}
