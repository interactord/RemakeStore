//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift

@testable import RemakeStore

class ObserableTypeSpec: XCTestCase {

  var disposebBag: DisposeBag?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    disposebBag = nil
  }

  func test_mapToVoid() {
    let expectedCell = XCTestExpectation(description: "called event")
    disposebBag = DisposeBag()

    guard let disponseBag = disposebBag else {
      fatalError("Should be not nil")
    }

    _ = Observable<String>.just("test")
      .mapToVoid()
      .subscribe(onNext: { _ in
        expectedCell.fulfill()
      }).disposed(by: disponseBag)

    wait(for: [expectedCell], timeout: 5.0)
  }

}
