//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class NSLocalizedTranslatorSpec: XCTestCase {

	var sut: NSLocalizedStringTranslator?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_inject_dummyKey_init() {
		let expectedKey = "test.global"

		sut = NSLocalizedStringTranslator()
		let action = sut?.translation(for: expectedKey)

		XCTAssertEqual(expectedKey, action)
	}
}