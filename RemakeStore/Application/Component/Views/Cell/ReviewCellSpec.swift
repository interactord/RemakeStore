//
// Created by Scott Moon on 2019-05-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class ReviewCellSpec: XCTestCase {

	var sut: ReviewCell?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_prepareForReuse() {
		sut = ReviewCell(frame: .zero)
		sut?.prepareForReuse()
		XCTAssertNotNil(sut)
	}

	func test_bind() {

		let testLabel = Label(label: "test")
		let ratingLabel = Label(label: "1")
		let entry = Entry(
			author: Author(name: testLabel), title: testLabel, content: testLabel, rating: ratingLabel
		)

		let viewModel: ReviewsEntryViewModeling = ReviewsEntryViewModel(withEntry: entry)

		sut = ReviewCell(frame: .zero)
		sut?.bind(to: viewModel)
		sut?.updateConstraints()
		XCTAssertNotNil(sut)

	}
}
