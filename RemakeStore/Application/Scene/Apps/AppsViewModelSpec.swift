//
// Created by Scott Moon on 2019-05-15.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift

@testable import RxSwift

class AppsViewModelSpec: XCTestCase {
	var sut: AppsViewModel?

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

	func makeSUT() -> AppsViewModel {
		var serviceDIContainer = ServiceDIContainer()
		let service = serviceDIContainer.service

		return AppsViewModel(with: service)
	}
}
