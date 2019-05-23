//
// Created by Scott Moon on 2019-05-23.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class UIScrollViewConverSpec: XCTestCase {

  var sut: UIScrollView?
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_scrollEnabled() {
    sut = UIScrollView()
    sut?.clankingScrollEffect(to: 0)

    XCTAssertNotNil(sut)
  }

}
