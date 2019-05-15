//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class ServiceDIContainerSpec: XCTestCase {
	var sut: ServiceDIContainer?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = ServiceDIContainer()
    XCTAssertNotNil(sut?.service)
	}
}
