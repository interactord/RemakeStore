//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayViewModelSpec: XCTestCase {

	var sut: TodayViewModel?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = makeSUT()
		XCTAssertNotNil(sut)
	}

	func makeSUT() -> TodayViewModel {
		var serviceDIContainer = ServiceDIContainer()
		let service = serviceDIContainer.service

		return TodayViewModel(with: service)
	}
}
