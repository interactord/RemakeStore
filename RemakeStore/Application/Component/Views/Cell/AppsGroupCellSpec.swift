//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxCocoa
import RxFlow

@testable import RemakeStore

class AppsGroupCellSpec: XCTestCase {
  var sut: AppsGroupCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
      sut = AppsGroupCell()

      XCTAssertNotNil(sut)
  }

  func test_prepareForReuse() {
    sut = AppsGroupCell()
    sut?.prepareForReuse()

    XCTAssertNotNil(sut)
  }

  func test_bind_viewModel() {
    sut = AppsGroupCell()
    sut?.bind(to: makeFeedViewModeling())

    XCTAssertNotNil(sut)
  }

  func test_bind_stepper() {
    let stepper = PublishRelay<Step>()
    sut = AppsGroupCell()
    sut?.bind(to: stepper)

    XCTAssertNotNil(sut)
  }

  func makeFeedViewModeling() -> FeedViewModeling {

    let feed = Feed(title: "title", results: [
      FeedResult(id: "test", name: "testApp", artistName: "test", artworkUrl100: "test.com"),
      FeedResult(id: "test", name: "testApp", artistName: "test", artworkUrl100: "test.com"),
      FeedResult(id: "test", name: "testApp", artistName: "test", artworkUrl100: "test.com")
    ])

    return FeedViewModel(withFeed: feed)
  }
}
