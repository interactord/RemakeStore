//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

private enum ErrorMock: Error {
	case dataEmpty
	case dataInvalid
}

class SerializationErrorSpec: XCTestCase {

	var sut: SerializationError?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_inject_error_init() {

		let expectedKey = "error.global.default"
		let expectedError = ErrorMock.dataInvalid
		sut = SerializationError(error: expectedError)

		guard let sutError = sut?.raw as? ErrorMock else {
			XCTFail("should be not nil")
			return
		}

		XCTAssertEqual(expectedError.localizedDescription, sutError.localizedDescription)
		XCTAssertEqual(expectedKey, sut?.messageKey)
	}
}
