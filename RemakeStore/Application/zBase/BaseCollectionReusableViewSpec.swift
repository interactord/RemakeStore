//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

@testable import RemakeStore

class BaseCollectionReusableViewSpec: XCTestCase {
  var sut: BaseCollectionReusableView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    let expectedFrame: CGRect = .zero
    sut = BaseCollectionReusableView()

    XCTAssertNotNil(sut)
    XCTAssertEqual(expectedFrame, sut?.frame)
  }

  func test_prepareForReuse() {
    sut = BaseCollectionReusableView()
    sut?.prepareForReuse()

    XCTAssertNotNil(sut)
  }
}
