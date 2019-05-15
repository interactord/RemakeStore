//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

@testable import RemakeStore

class SocialAppViewModelSpec: XCTestCase {

  var sut: SocialAppViewModel?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = SocialAppViewModel(withSocialApp: makeSocialAppData())
    XCTAssertNotNil(sut)
  }

  func test_output() {
    let expectedName = "test title"
    let expectedImageUrl = "test-image.com"
    let expectedTagLine = "test tag"

    sut = SocialAppViewModel(withSocialApp: makeSocialAppData())

    XCTAssertEqual(expectedName, try sut?.outputs.name.toBlocking().first())
    XCTAssertEqual(expectedImageUrl, try sut?.outputs.imageUrlPath.toBlocking().first())
    XCTAssertEqual(expectedTagLine, try sut?.outputs.tagLine.toBlocking().first())
  }

  func makeSocialAppData() -> SocialApp {
    return SocialApp(
      id: "123", name: "test title", imageUrl: "test-image.com", tagline: "test tag"
    )
  }
}
