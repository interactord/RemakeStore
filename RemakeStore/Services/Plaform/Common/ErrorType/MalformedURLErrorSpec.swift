//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class MalformedURLErrorSpec: XCTestCase {

	var sut: MalformedURLError?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {

		let expectedKey = "error.global.network"
		sut = MalformedURLError()

		guard let sut = sut else {
			fatalError("Should be not nil")
		}

		XCTAssertNil(sut.raw)
		XCTAssertEqual(expectedKey, sut.messageKey)
	}
}
