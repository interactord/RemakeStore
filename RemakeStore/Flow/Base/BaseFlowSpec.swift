//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxFlow

@testable import RemakeStore

class BaseFlowSpec: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_navigateToStep() {
    var container = ServiceDIContainer()
    let mock = BaseFlowMock(with: container.service)

    XCTAssertNotNil(mock.makeContributor(with: .none, flow: mock))
    XCTAssertNotNil(mock.navigate(to: .dashboardIsRequired))
    XCTAssertNotNil(mock.navigate(to: TestStepMock.none))
  }

}
