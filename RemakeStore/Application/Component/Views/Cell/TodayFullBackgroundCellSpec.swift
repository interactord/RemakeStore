//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayFullBackgroundCellSpec: XCTestCase {
  var sut: TodayFullBackgroundCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayFullBackgroundCell()
    XCTAssertNotNil(sut)
  }
}
