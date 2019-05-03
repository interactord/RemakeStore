//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import SCServiceKit
@testable import RemakeStore

class AppHTTPErrorHandlerSpec: XCTestCase {

	var sut: AppHTTPErrorHandler?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_inject_responseMock_handle() {

		guard let url = URL(string: "https://test.com") else {
			fatalError("Should be not nil")
		}

		let request = URLRequest(url: url)
		let response = AppResponse(request: request, error: nil)

		sut = AppHTTPErrorHandler()

		XCTAssertNotNil(sut?.handle(response: response))

	}
}
