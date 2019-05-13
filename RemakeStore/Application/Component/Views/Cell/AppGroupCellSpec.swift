//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppGroupCellSpec: XCTestCase {
  var sut: AppGroupCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
      sut = AppGroupCell()

      XCTAssertNotNil(sut)
  }
}
