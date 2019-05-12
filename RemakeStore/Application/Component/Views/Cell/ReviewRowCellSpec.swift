//
// Created by Scott Moon on 2019-05-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class ReviewRowCellSpec: XCTestCase {

  var sut: ReviewRowCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_prepareForReuse() {
    sut = ReviewRowCell(frame: .zero)
    sut?.prepareForReuse()
    XCTAssertNotNil(sut)
  }

  func test_bind() {

    let testLabel = Label(label: "test")
    let ratingLabel = Label(label: "1")
    let entry = Entry(
      author: Author(name: testLabel), title: testLabel, content: testLabel, rating: ratingLabel
    )

    let viewModels: [ReviewsEntryViewModeling] = [
      ReviewsEntryViewModel(withEntry: entry),
      ReviewsEntryViewModel(withEntry: entry)
    ]

    sut = ReviewRowCell(frame: .zero)
    sut?.bind(to: viewModels)
    sut?.updateConstraints()
    XCTAssertNotNil(sut)

  }
}
