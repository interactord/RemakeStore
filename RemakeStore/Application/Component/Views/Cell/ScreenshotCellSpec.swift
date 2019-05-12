//
// Created by Scott Moon on 2019-05-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class ScreenshotCellSpec: XCTestCase {

	var sut: ScreenshotCell?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = ScreenshotCell(frame: .zero)
		XCTAssertNotNil(sut)
	}

	func test_prepareForReuse() {
		sut = ScreenshotCell(frame: .zero)
		sut?.prepareForReuse()
		XCTAssertNotNil(sut)
	}

	func test_bind() {

		let viewModel: ScreenshotViewModeling = ScreenshotViewModel(withScreenshot: "test.com")

		sut = ScreenshotCell(frame: .zero)
		sut?.bind(to: viewModel)
		sut?.updateConstraints()
		XCTAssertNotNil(sut)

	}
}
