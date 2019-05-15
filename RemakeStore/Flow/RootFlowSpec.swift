//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

@testable import RemakeStore

class RootFlowSpec: XCTestCase {

	var sut: RootFlow?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = RootFlow(with: makeService())
		XCTAssertNotNil(sut)
	}

	func test_OnDebugNavigate() {
		sut = RootFlow(with: makeService())
		sut?.onDebugNavigate()
		XCTAssertNotNil(sut)
	}

	func test_Start() {
		let window = UIWindow()
		sut = RootFlow(with: makeService())
		sut?.start(with: window)
		XCTAssertNotNil(sut)
	}

	func makeService() -> Service {
		var serviceDIContainer = ServiceDIContainer()
		return serviceDIContainer.service
	}
}
