//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import SCServiceKit

class DeserializationErrorSpec: XCTestCase {

	var sut: DeserializationError?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_inject_developer_message_init() {

		let expectedKey = "error.global"
		let expectedMessage = "test error"

		sut = DeserializationError(developerMessage: expectedMessage)

		XCTAssertNil(sut?.raw)
		XCTAssertEqual(expectedKey, sut?.messageKey)
	}
}
