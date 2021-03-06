//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class BaseControllerSpec: XCTestCase {

  var sut: BaseController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_override_call() {
    sut = BaseController()

    sut?.steps.accept(AppStep.none)
    sut?.viewDidLoad()
    sut?.updateViewConstraints()
  }

}
