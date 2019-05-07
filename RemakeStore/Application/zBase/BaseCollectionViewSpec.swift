//
// Created by Scott Moon on 2019-05-07.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import UIKit

@testable import RemakeStore

class BaseCollectionViewSpec: XCTestCase {

	var sut: BaseCollectionView?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = BaseCollectionView()
		XCTAssertNotNil(sut)
	}

	func test_init_coder() {
		sut = BaseCollectionView(coder: NSCoder())
		XCTAssertNotNil(sut)
	}
}
