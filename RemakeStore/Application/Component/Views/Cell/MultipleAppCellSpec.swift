//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class MultipleAppCellSpec: XCTestCase {

	var sut: MultipleAppCell?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = MultipleAppCell()

		XCTAssertNotNil(sut)
	}
}
