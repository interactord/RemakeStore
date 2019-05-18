//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayDetailViewModelSpec: XCTestCase {

  var sut: TodayDetailViewModel?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = makeSUT()

    XCTAssertNotNil(sut)
  }

  func makeSUT() -> TodayDetailViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service

    return TodayDetailViewModel(with: service)
  }

}
