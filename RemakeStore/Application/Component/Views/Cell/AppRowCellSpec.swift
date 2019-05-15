//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppRowCellSpec: XCTestCase {
  var sut: AppRowCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
      sut = AppRowCell()

      XCTAssertNotNil(sut)
  }

  func test_prepareForReuse() {
    sut = AppRowCell()
    sut?.prepareForReuse()

    XCTAssertNotNil(sut)
  }

  func test_bind() {
    sut = AppRowCell()
    sut?.bind(to: makeViewModel())

    XCTAssertNotNil(sut)
  }

  func makeViewModel() -> FeedResultViewModeling {
    let feedResult = FeedResult(
      id: "123", name: "testName", artistName: "test", artworkUrl100: "test.com"
    )

    return FeedResultViewModel(withFeedResult: feedResult)
  }
}
