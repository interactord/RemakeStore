//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class SearchDIContainterSpec: XCTestCase {
	var sut: SearchDIContainer?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = SearchDIContainer(with: makeService())
    XCTAssertNotNil(sut?.getController())
	}

 func makeService() -> Service {
    var serviceDIContainer = ServiceDIContainer()
    return serviceDIContainer.service
  }
}
