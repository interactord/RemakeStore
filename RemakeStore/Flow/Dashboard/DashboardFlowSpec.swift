//
// Created by Scott Moon on 2019-05-21.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class DashboardFlowSpec: XCTestCase {
  var sut: DashboardFlow?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_init() {
    let service = makeService()
    sut = DashboardFlow(with: service)

    XCTAssertNotNil(sut)
  }

  func test_navigate() {
    let service = makeService()
    sut = DashboardFlow(with: service)

    XCTAssertNotNil(sut?.navigate(to: AppStep.dashboardIsComplete))
    XCTAssertNotNil(sut?.navigate(to: AppStep.todayDetailIsComplete))
  }

  func makeService() -> Service {
    var serviceDIContainer = ServiceDIContainer()
    return serviceDIContainer.service
  }
}
