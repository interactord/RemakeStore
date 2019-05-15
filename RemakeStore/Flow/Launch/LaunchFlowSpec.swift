//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import RxFlow

@testable import RemakeStore

class LaunchFlowSpec: XCTest {
  var sut: LaunchFlow?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = LaunchFlow(with: makeService())
    XCTAssertNotNil(sut)
  }

  func test_navigate_notNone() {
    sut = LaunchFlow(with: makeService())
    XCTAssertNotNil(sut?.navigate(to: AppStep.dashboardIsRequired))
  }

  func test_navigate_none() {
    sut = LaunchFlow(with: makeService())
    XCTAssertNotNil(sut?.navigate(to: AppStep.dashboardIsComplete))
  }

  func makeService() -> Service {
    var serviceDIContainer = ServiceDIContainer()
    return serviceDIContainer.service
  }
}
