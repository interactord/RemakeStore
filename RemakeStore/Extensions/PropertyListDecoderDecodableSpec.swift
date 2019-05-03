//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import SCServiceKit
@testable import RemakeStore

class PropertyListDecoderDecodableSpec: XCTestCase {

	var sut: PropertyListDecoder?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_noInject_url_deserialize() {

		sut = PropertyListDecoder()

		let expectedModel: EnvConfigModel? = sut?.deserialize()

		XCTAssertNil(expectedModel)
	}

	func test_inject_envPlist_deserialize() {

		let url = Bundle.main.url(forResource: "env", withExtension: "plist")

		sut = PropertyListDecoder()

		let expectedModel: EnvConfigModel? = sut?.deserialize(with: url)

		XCTAssertNotNil(expectedModel)
	}
}
