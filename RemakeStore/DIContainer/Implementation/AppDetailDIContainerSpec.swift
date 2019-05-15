//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppDetailDIContainerSpec: XCTestCase {
	var sut: AppDetailDIContainer?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = AppDetailDIContainer(with: makeService(), appId: 123)

    XCTAssertNotNil(sut?.getController())
	}

  func makeService() -> Service {
    var serviceDIContainer = ServiceDIContainer()
    return serviceDIContainer.service
  }
}
