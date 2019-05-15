//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

@testable import RemakeStore

class FeedResultViewModelSpec: XCTestCase {

  var sut: FeedResultViewModel?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = FeedResultViewModel(withFeedResult: makeFeedResult())
    XCTAssertNotNil(sut)
  }

  func test_output() throws {
    let expectedName = "testApp"
    let expectedCompanyName = "test"
    let expectedIconImageUrlPath = "test.com"
    let expectedId = "123"

    sut = FeedResultViewModel(withFeedResult: makeFeedResult())

    XCTAssertEqual(expectedName, try sut?.outputs.name.toBlocking().first())
    XCTAssertEqual(expectedCompanyName, try sut?.outputs.companyName.toBlocking().first())
    XCTAssertEqual(expectedIconImageUrlPath, try sut?.outputs.iconImageUrlPath.toBlocking().first())
    XCTAssertEqual(expectedId, try sut?.outputs.id.toBlocking().first())
  }

  func makeFeedResult() -> FeedResult {
    return FeedResult(
      id: "123",
      name: "testApp",
      artistName: "test",
      artworkUrl100: "test.com"
    )
  }
}
