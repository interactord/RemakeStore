//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsHeaderCellSpec: XCTestCase {
  var sut: AppsHeaderCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = AppsHeaderCell()
    XCTAssertNotNil(sut)
  }

  func test_prepareForReuse() {
    sut = AppsHeaderCell()
    sut?.prepareForReuse()
    XCTAssertNotNil(sut)
  }

  func test_bind() {
    sut = AppsHeaderCell()
    sut?.bind(to: makeViewModel())
    XCTAssertNotNil(sut)
  }

  func makeViewModel() -> SocialAppViewModel {
    return SocialAppViewModel(withSocialApp: SocialApp(
      id: "123", name: "test name", imageUrl: "test-image.com", tagline: "test tag"))
  }
}
