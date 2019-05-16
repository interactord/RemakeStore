//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayControllerSpec: XCTestCase {

  var sut: TodayController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayController()
    XCTAssertNotNil(sut)
  }

  func test_viewDidLoad() {
    sut = TodayController()
    sut?.viewDidLoad()
    XCTAssertNotNil(sut)
  }

  func test_setupConstraints() {
    sut = TodayController()
    sut?.setupConstraints()
    XCTAssertNotNil(sut)
  }
}
