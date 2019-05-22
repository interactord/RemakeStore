//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayDetailContentsViewSpec: XCTestCase {

	var sut: TodayDetailContentsView?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = TodayDetailContentsView()
		XCTAssertNotNil(sut)
	}
}
