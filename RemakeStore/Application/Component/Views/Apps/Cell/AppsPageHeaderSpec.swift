//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsPageHeaderSpec: XCTestCase {
  var sut: AppsPageHeader?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = AppsPageHeader()
    XCTAssertNotNil(sut)
  }

  func test_bind() {
    sut = AppsPageHeader()
    sut?.bind(to: makeViewModels())

    XCTAssertNotNil(sut)
  }

   func makeViewModels() -> [SocialAppViewModel] {
    return [
      SocialAppViewModel(withSocialApp: SocialApp(
        id: "123", name: "test name", imageUrl: "test-image.com", tagline: "test tag"))
    ]
  }
}
