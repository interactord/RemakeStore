//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

@testable import RemakeStore

class ReviewsEntryViewModelSpec: XCTestCase {
  var sut: ReviewsEntryViewModel?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = ReviewsEntryViewModel(withEntry: makeEntry())
    XCTAssertNotNil(sut)
  }

  func makeEntry() -> Entry {
    return Entry(
      author: Author(name: Label(label: "author")),
      title: Label(label: "title"),
      content: Label(label: "content"),
      rating: Label(label: "4.0")
    )
  }

}
