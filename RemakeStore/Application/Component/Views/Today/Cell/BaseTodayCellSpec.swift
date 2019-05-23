//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class BaseTodayCellSpec: XCTestCase {

	var sut: BaseTodayCell?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = BaseTodayCell()
		XCTAssertNotNil(sut)
	}

  func test_isHighlighted() {
    let expectedTransform: CGAffineTransform = .init(scaleX: 0.9, y: 0.9)

    sut = BaseTodayCell()
    sut?.isHighlighted = true

    XCTAssertEqual(expectedTransform, sut?.transform)
  }
}
