//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

@testable import RemakeStore

class FeedViewModelSpec: XCTestCase {
	var sut: FeedViewModel?

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	func test_init() {
		sut = FeedViewModel(withFeed: makeFeed())
		XCTAssertNotNil(sut)
	}

	func test_output() {
    let expectedTitle = "title"
    let expectedCount = 3
		sut = FeedViewModel(withFeed: makeFeed())

    XCTAssertEqual(expectedTitle, try sut?.outputs.title.toBlocking().first())
    XCTAssertEqual(expectedCount, try sut?.outputs.feedResultViewModel.toBlocking().first()?.count)
	}

	func makeFeed() -> Feed {
		return Feed(title: "title", results: [
			FeedResult(id: "test", name: "testApp", artistName: "test", artworkUrl100: "test.com"),
			FeedResult(id: "test", name: "testApp", artistName: "test", artworkUrl100: "test.com"),
			FeedResult(id: "test", name: "testApp", artistName: "test", artworkUrl100: "test.com")
		])
	}
}
