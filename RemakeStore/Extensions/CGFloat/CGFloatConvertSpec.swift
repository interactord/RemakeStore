//
// Created by Scott Moon on 2019-05-23.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

@testable import RemakeStore

class CGFloatCOnvertSpec: XCTestCase {
  var sut: CGFloat?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_convertDragScaleTranform() {
    let expectedMinScaleTranform: CGAffineTransform = .init(scaleX: 1, y: 1)
    let expectedMaxScaleTranfrom: CGAffineTransform = .init(scaleX: 0.89, y: 0.89)

    sut = -160
    let resultMinScaleTranform = sut?.convertDragScaleTranform(withOffset: 0.0)
    XCTAssertEqual(expectedMinScaleTranform, resultMinScaleTranform)

    sut = 160
    let resultMaxScaleTranfrom = sut?.convertDragScaleTranform(withOffset: 0.0)
    XCTAssertEqual(expectedMaxScaleTranfrom, resultMaxScaleTranfrom)
  }
}
