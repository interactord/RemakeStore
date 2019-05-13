//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsGroupCellSpec: XCTestCase {
  var sut: AppsGroupCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
      sut = AppsGroupCell()

      XCTAssertNotNil(sut)
  }
}
