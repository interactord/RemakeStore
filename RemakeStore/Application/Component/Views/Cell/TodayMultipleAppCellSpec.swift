//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayMultipleAppCellSpec: XCTestCase {
  var sut: TodayMultipleAppCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayMultipleAppCell()
    XCTAssertNotNil(sut)
  }
}
