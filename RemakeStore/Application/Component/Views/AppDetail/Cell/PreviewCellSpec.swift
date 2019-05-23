//
// Created by Scott Moon on 2019-05-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class PreviewCellSpec: XCTestCase {

	var sut: PreviewCell?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = PreviewCell(frame: .zero)
		XCTAssertNotNil(sut)
	}

	func test_prepareForReuse() {
		sut = PreviewCell(frame: .zero)
		sut?.prepareForReuse()
		XCTAssertNotNil(sut)
	}

	func test_bind() {

		let viewModels: [ScreenshotViewModeling] = [
      ScreenshotViewModel(withScreenshot: "test.com"),
      ScreenshotViewModel(withScreenshot: "test.com"),
      ScreenshotViewModel(withScreenshot: "test.com")
    ]

		sut = PreviewCell(frame: .zero)
		sut?.bind(to: viewModels)
		sut?.updateConstraints()
		XCTAssertNotNil(sut)

	}
}
