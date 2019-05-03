//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import Foundation

@testable import RemakeStore

class AnyInterceptorSpec: XCTestCase {

	var sut: AnyInterceptor<String>?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_inject_mock_init() {

		let mock = StringMockInterceptor(string: "Test")
		sut = AnyInterceptor<String>(base: mock)

	}
}
