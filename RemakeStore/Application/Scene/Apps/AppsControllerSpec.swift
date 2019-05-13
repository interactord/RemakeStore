//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsControllerSpec: XCTestCase {
	var sut: AppsController?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_viewDidLoad() {
		sut = AppsController()
		sut?.viewDidLoad()

		XCTAssertNotNil(sut)
	}

	func test_setConstant() {
		sut = AppsController()
		sut?.setupConstraints()
		XCTAssertNotNil(sut)
	}
}
